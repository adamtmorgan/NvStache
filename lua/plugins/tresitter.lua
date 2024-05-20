return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treeSitterConfig = require("nvim-treesitter.configs")
		treeSitterConfig.setup({
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"html",
				"css",
				"rust",
				"toml",
				"ron",
			},
			--sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
