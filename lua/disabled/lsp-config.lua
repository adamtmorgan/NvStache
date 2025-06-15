return {
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
			-- Setup key bindings for lsp
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "ge", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},
}
