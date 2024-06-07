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
				"wgsl",
				"glsl",
				"php",
				"python",
				"kotlin",
				"java",
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
				"terraform",
				"csv",
				"dockerfile",
				"gitignore",
				"json",
				"graphql",
				"markdown",
				"regex",
				"csv",
				"tsv",
				"psv",
			},
			--sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			--autopairs = { enable = true },
			--autotag = { enable = true },
		})
	end,
}
