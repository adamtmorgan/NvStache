return {
	"nvim-treesitter/nvim-treesitter",
	--dependencies = { "windwp/nvim-ts-autotag" },
	build = ":TSUpdate",
	config = function()
		local treeSitterConfig = require("nvim-treesitter.configs")
		treeSitterConfig.setup({
			ensure_installed = {
				-- Programming/styling languages
				"jsdoc",
				"javascript",
				"typescript",
				"tsx",
				"vue",
				"svelte",
				"html",
				"css",
				"scss",
				"rust",
				"lua",
				"wgsl",
				"glsl",
				"php",
				"python",
				"kotlin",
				"java",
				"arduino",

				-- Data
				"sql",
				"graphql",
				"json",
				"csv",
				"tsv",
				"psv",

				-- Config languages
				"toml",
				"yaml",
				"ron",
				"terraform",
				"dockerfile",
				"gitignore",
				"nginx",

				-- System scripting
				"bash",
				"nix",

				-- Misc
				"markdown",
				"regex",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
