return {
	--------------------------------------------------------
	-- Mason is a package manager for various CLI and
	-- server applications that connect to neovim for
	-- various LSP, formatting, and other features.
	--------------------------------------------------------
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()

			-- Checks listed packages and installs them
			-- if they are not already:

			local registry = require("mason-registry")

			-- These are package names sourced from the Mason registry,
			-- and may not necessarily match the server names used in lspconfig.
			-- Apply version property if a specific version is desired.
			local ensure_installed = {
				-- LSPs
				{ name = "codelldb" }, -- Debugging for Rust/C/C++/Zig
				{ name = "cpptools" }, -- Debugging for Rust/C/C++
				{ name = "lua-language-server" }, -- lua
				{ name = "typescript-language-server" }, -- typescript
				{ name = "vue-language-server", version = "3.0.0-alpha.10" }, -- aka "volar" - vue
				{ name = "vtsls" },
				{ name = "eslint-lsp" }, -- javascript
				{ name = "json-lsp" }, -- json
				{ name = "yaml-language-server" }, -- yaml
				{ name = "html-lsp" }, -- html
				{ name = "css-lsp" }, -- css
				{ name = "intelephense" }, -- php
				{ name = "pyright" }, -- python
				{ name = "rust-analyzer" }, -- rust
				{ name = "clangd" }, -- C, C++
				{ name = "taplo" }, -- toml
				{ name = "sqlls" }, -- sql
				{ name = "bash-language-server" }, -- bash
				{ name = "dockerfile-language-server" }, -- docker
				{ name = "docker-compose-language-service" }, -- docker compose
				{ name = "terraform-ls" }, -- terraform
				{ name = "rnix-lsp" }, -- nix
				{ name = "graphql-language-service-cli" }, -- graphql
				{ name = "buf" }, -- gRPC/Protobuf
				{ name = "glsl_analyzer" }, -- webgl
				{ name = "wgsl-analyzer" }, -- webgpu

				-- Formatting
				{ name = "prettierd" }, -- Formatting for various common filetypes
				{ name = "clang-format" }, -- Formatting C, C++
			}

			-- Ensure packages are installed and up to date
			registry.refresh(function()
				for _, package_details in pairs(ensure_installed) do
					local package = registry.get_package(package_details.name)
					local current_version = package:get_installed_version()
					local install_version = package:get_latest_version()
					if package_details.version ~= nil then
						install_version = package_details.version
					end
					local updated = current_version == install_version
					local installed = registry.is_installed(package_details.name)
					if not installed or not updated then
						package:install({ version = install_version })
					end
				end
			end)
		end,
	},

	--------------------------------------------------------
	-- Lang-specific plugins/toolsets
	--------------------------------------------------------

	-- Rust
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false, -- This plugin is already lazy
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					float_win_config = {
						border = "rounded",
					},
				},
			}
		end,
	},

	-- Apple dev ecosystem (MacOS, iOS, WatchOS, etc.)
	-- https://github.com/wojciech-kulik/xcodebuild.nvim/wiki
	-- {
	-- 	"wojciech-kulik/xcodebuild.nvim",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
	-- 	},
	-- 	config = function()
	-- 		require("xcodebuild").setup({
	-- 			-- put some options here or leave it empty to use default settings
	-- 		})
	-- 	end,
	-- },

	-- TypeScript
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		-- Vue plugin must be installed for vue to work
		-- `npm i -g @vue/typescript-plugin`
		config = function()
			require("typescript-tools").setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
				},
				settings = {
					tsserver_plugins = {
						"@vue/typescript-plugin",
					},
				},
			})
		end,
	},

	--------------------------------------------------------
	-- Nvim LSP Config. Provides decent default LSP configs.
	-- https://github.com/neovim/nvim-lspconfig
	--------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		-- Picker is a dependency to ensure that it loads prior to lsp startup, as it
		-- overrides the select menu for code actions.
		dependencies = { "Fildo7525/pretty_hover", "folke/snacks.nvim" },
		config = function()
			local lspconfig = require("lspconfig")

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								vim.fn.expand("$VIMRUNTIME/lua"),
								vim.fn.stdpath("config") .. "/lua",
								vim.fn.stdpath("data") .. "/lazy", -- Lazy plugin directory
							},
						},
					},
				},
			})

			-- IMPORTANT: It is crucial to ensure that @vue/typescript-plugin and @vue/language-server
			vim.lsp.config("vue_ls", {
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})

			vim.lsp.config("clangd", {
				filetypes = { "c", "cpp", "objc", "cuda" },
			})
			vim.lsp.config("html", {
				filetypes = { "html" },
				on_attach = function(client, bufnr)
					-- Was having weird attachment issues with Vue, so forced
					-- to stop client if filetype is not html.
					if vim.bo[bufnr].filetype ~= "html" then
						client.stop()
					end
				end,
			})
			vim.lsp.config("cssls", {
				filetypes = { "css", "scss", "less" },
			})

			vim.lsp.config("graphql", {
				root_dir = lspconfig.util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json", ".git"),
				filetypes = { "graphql", "graphqlrc", "graphqlconfig" },
			})
			vim.lsp.config("bufls", {
				cmd = { "buf" },
			})
			vim.lsp.config("bashls", {
				filetypes = { "zsh", "sh", "bash" },
			})

			vim.lsp.config("wgsl_analyzer", {
				cmd = { "wgsl_analyzer" },
			})

			vim.lsp.enable({
				"lua_ls",
				-- "ts_ls", -- Disable when hybrid mode for vue_ls is disabled or if using typescript_tools
				"vtsls",
				"vue_ls",
				"eslint",
				"intelephense",
				"clangd",
				"pyright",
				"html",
				"cssls",
				"jsonls",
				"yamlls",
				"taplo",
				"sqlls",
				"dockerls",
				"docker_compose_language_service",
				"graphql",
				"bufls",
				"sourcekit",
				"bashls",
				"rnix",

				-- Terraform requires a separate config
				-- that I don't have set up right now.
				--"terraform_ls",
				"glsl_analyzer",
				"wgsl_analyzer",
			})

			-- Setup key bindings for lsp
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "ge", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},

	--------------------------------------------------------
	-- Wires up formatters installed via Mason (or manually)
	-- to the current buffer.
	--------------------------------------------------------
	{
		"stevearc/conform.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local conform = require("conform")

			conform.setup({
				-- format_on_save = {
				-- 	lsp_fallback = true,
				-- 	async = false,
				-- 	timeout_ms = 500,
				-- },
				default_format_opts = {
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					typescript = { "prettierd" },
					javascript = { "prettierd" },
					typescriptreact = { "prettierd" },
					javascriptreact = { "prettierd" },
					vue = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					graphql = { "prettierd" },
					css = { "prettierd" },
					scss = { "prettierd" },
					markdown = { "prettierd" },
					html = { "prettierd" },
					rust = { "rustfmt" },
					c = { "clang-format" },
					glsl = { "clang-format" },
					wgsl = { "wgsl-analyzer", lsp_format = "prefer" }, -- uses lsp
					bash = { "shfmt" },
					toml = { "taplo" },
				},
			})

			-- Set keymap for format
			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format()
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	--------------------------------------------------------
	-- Debugging
	--------------------------------------------------------
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- keybindings
			local map = vim.keymap.set

			-- map("n", ";", ":", { desc = "CMD enter command mode" })

			-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

			-- Nvim DAP
			map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
			map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
			map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
			map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
			map(
				"n",
				"<Leader>db",
				"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
				{ desc = "Debugger toggle breakpoint" }
			)
			map(
				"n",
				"<Leader>dd",
				"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				{ desc = "Debugger set conditional breakpoint" }
			)
			map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
			map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

			-- rustaceanvim
			map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

	--------------------------------------------------------
	--Error tracking with `trouble`
	--------------------------------------------------------
	{
		"folke/trouble.nvim",
		opts = { focus = true }, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
