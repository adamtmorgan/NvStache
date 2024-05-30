return {
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
					"lua_ls", -- lua
					"tsserver", -- typescript
					"eslint_d", -- javascript
					"vuels", -- vue.js
					"jsonls", -- json
					"html", -- html
					"cssls", -- css
					"pyright", -- python
					"rust_analyzer", -- rust
					"taplo", -- toml
					"sqlls", -- sql
					"bashls", -- bash
					"dockerls", -- docker
					"docker_compose_language_service", -- docker compose
					"terraform_ls", -- terraform
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
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
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
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
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

			-- Setup key bindings for lsp
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "ge", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},

	--------------------------------------------------------
	-- Linting configuration
	--------------------------------------------------------
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				--typescript = { "eslint_d " },
				javascriptreact = { "eslint_d" },
				--typescriptreact = { "eslint_d" },
				kotlin = { "ktlint" },
				terraform = { "tflint" },
				html = { "htmlhint" },
				css = { "stylelint" },
				sql = { "sqlfluff" },
			}

			--local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = "true" })
			local lint_augroup = vim.api.nvim_create_augroup("lint", {})

			-- Trigger when linting happens
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
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
					kotlin = { "ktlint" },
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
}
