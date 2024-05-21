return {
	"nvim-treesitter/nvim-treesitter",
	--dependencies = { "windwp/nvim-ts-autotag" },
	build = ":TSUpdate",
	config = function()
		local treeSitterConfig = require("nvim-treesitter.configs")
		treeSitterConfig.setup({
			ensure_installed = {
				"lua",
				"bash",
				"jsdoc",
				"javascript",
				"typescript",
				"python",
				"tsx",
				"html",
				"css",
				"scss",
				"rust",
				"toml",
				"yaml",
				"ron",
				"vue",
				"sql",
			},
			--sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			--autopairs = { enable = true },
			--autotag = { enable = true },
		})
	end,
}
