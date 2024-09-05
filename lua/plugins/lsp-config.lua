return {
	--------------------------------------------------------
	-- Lang-specific plugins
	--------------------------------------------------------

	-- Rust
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},

	--------------------------------------------------------
	-- Mason LSP. Grants us LSP support in Neovim.
	--------------------------------------------------------
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	--------------------------------------------------------
	-- Mason LSP Config. Helps us install the LSPs
	-- themselves so we don't have to do it manually.
	-- https://github.com/williamboman/mason-lspconfig.nvim
	--------------------------------------------------------
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"codelldb", -- Debugging for Rust/C/C++/Zig
					"cpptools", -- Debugging for Rust/C/C++
					"lua_ls", -- lua
					"tsserver", -- typescript
					"eslint", -- javascript
					"vuels", -- vue.js
					"jsonls", -- json
					"html", -- html
					"cssls", -- css
					"intelephense", -- php
					"pyright", -- python
					"rust_analyzer", -- rust
					"taplo", -- toml
					"sqlls", -- sql
					"bashls", -- bash
					"dockerls", -- docker
					"docker_compose_language_service", -- docker compose
					"terraformls", -- terraform
					"rnix", -- nix
					"graphql", -- graphql
					"glsl_analyzer", -- webgl
					"wgsl_analyzer", -- webgpu
					"bashls", -- bash
				},
			})
		end,
	},

	--------------------------------------------------------
	-- Nvim LSP Config
	-- Wires up the lsp support and lsps themselves
	-- to the neovim instance.
	-- https://github.com/neovim/nvim-lspconfig
	--------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Here we reference the autocomplete lsp provider so that
			-- our autocomplete can use LSP data.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.intelephense.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.taplo.setup({
				capabilities = capabilities,
			})
			lspconfig.vuels.setup({
				capabilities = capabilities,
			})
			lspconfig.sqlls.setup({
				capabilities = capabilities,
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})
			lspconfig.docker_compose_language_service.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.rnix.setup({
				capabilities = capabilities,
			})

			-- No longer needed since using rustacianvim
			-- to manage rust features. Keeping here
			-- as reference just in case.

			-- lspconfig.rust_analyzer.setup({
			-- 	capabilities = capabilities,
			-- })

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.graphql.setup({
				capabilities = capabilities,
			})
			lspconfig.glsl_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.wgsl_analyzer.setup({
				capabilities = capabilities,
			})

			-- Terraform requires a separate config
			-- that I don't have set up right now.
			-- Check in on this later:

			--lspconfig.terraform_ls.setup({
			--	capabilities = capabilities,
			--})

			-- Add borders to our hover windows
			local _border = "rounded"

			local windowSettings = {
				border = _border,
			}

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, windowSettings)
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, windowSettings)
			vim.diagnostic.config({
				float = { border = _border },
			})
			require("lspconfig.ui.windows").default_options = windowSettings

			-- Setup key bindings for lsp
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "ge", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			-- vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "<leader>ca", function()
				require("tiny-code-action").code_action()
			end, { noremap = true, silent = true })

			-- These open up lsp features inside of telescope instead
			vim.api.nvim_set_keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', {})
			vim.api.nvim_set_keymap("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', {})
			vim.api.nvim_set_keymap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', {})
			vim.api.nvim_set_keymap("n", "gt", '<cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>', {})
			-- vim.api.nvim_set_keymap("n", "fs", '<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<CR>', {})
			vim.api.nvim_set_keymap(
				"n",
				"<leader>fs",
				'<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>',
				{}
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>fS",
				'<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>',
				{}
			)
		end,
	},

	--------------------------------------------------------
	-- Formatting configuration
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
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					typescript = { "prettierd" },
					javascript = { "prettierd" },
					typescriptreact = { "prettierd" },
					javascriptreact = { "prettierd" },
					json = { "prettierd", "prettier" },
					graphql = { "prettierd" },
					css = { "prettierd" },
					scss = { "prettierd" },
					markdown = { "prettierd" },
					html = { "htmlbeautifier" },
					rust = { "rustfmt" },
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

			map("n", ";", ":", { desc = "CMD enter command mode" })
			map("i", "jk", "<ESC>")

			-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

			-- Nvim DAP
			map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
			map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
			map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
			map("n", "<Leader>dc>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
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
