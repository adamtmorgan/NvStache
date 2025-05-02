return {
	-- For scrollbar. Use with gitsigns to show git changes
	-- in project.
	{
		"petertriho/nvim-scrollbar",
		dependencies = { "lewis6991/gitsigns.nvim", "kevinhwang91/nvim-hlslens" },
		config = function()
			require("scrollbar").setup({
				excluded_buftypes = {
					"terminal",
				},
				excluded_filetypes = {
					"dropbar_menu",
					"dropbar_menu_fzf",
					"DressingInput",
					"cmp_docs",
					"cmp_menu",
					"noice",
					"prompt",
					"TelescopePrompt",
					"blink-cmp",
					"blink-cmp-menu",
					"blink-cmp-signature",
					"blink-cmp-documentation",
				},
				handlers = {
					cursor = true,
					diagnostic = true,
					gitsigns = false, -- Requires gitsigns
					handle = true,
					search = true, -- Requires hlslens
				},
				handle = {
					color = "#56576f",
				},
				marks = {
					Cursor = {
						text = "◆",
						priority = 0,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "Normal",
					},
				},
			})
		end,
	},

	-- For better glancing at matched info in searches
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			-- require('hlslens').setup() is not required
			require("scrollbar.handlers.search").setup({
				-- hlslens config overrides
			})
		end,
	},

	-- For highlighting todo, fix and other tags in comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Adds comment formatting features
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},

	-- Adds support for documentation generation for
	-- a variety of languages.
	{
		"kkoomen/vim-doge",
		-- run `:call doge#install()` on first run
		config = function()
			vim.keymap.set("n", "<Leader>D", "<Plug>(doge-generate)<CR>")
		end,
	},

	-- Enhances crate composing in cargo.toml files
	{
		"saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("crates").setup({
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			})
		end,
	},

	-- Auto adds closing brackets, braces, etc.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	-- For editing enclosing chars or blocks
	-- 's' is used as an object reference. Just as if you'd say `ciw` to
	-- change inside word, you'd say `cs{[` to change a surrounding `{` to a `[`
	{
		-- "tpope/vim-surround",
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- Used to quickly align text vertically across rows.
	{
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set("x", "ga", ":EasyAlign ", { silent = true })
		end,
	},

	-- For auto-detecting and changing `shiftwidth` and `expandtab`
	-- settings based on the current file's pattern.
	{ "tpope/vim-sleuth" },

	-- Adds auto closing and renaming tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				--per_filetype = {
				--	["html"] = {
				--		enable_close = false,
				--	},
				--},
			})
		end,
	},

	-- Adds line guides to indents
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			use_treesitter = true,
		},
		config = function()
			local highlight = { "blankLineDim" }
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "blankLineDim", { fg = "#3f3b50" })
			end)

			require("ibl").setup({
				indent = { highlight = highlight, char = "▏" },
			})
		end,
	},

	-- Highlights symbol under the caret throughout the
	-- document
	{
		"RRethy/vim-illuminate",
		config = function()
			-- default configuration
			require("illuminate").configure({
				-- providers: provider used to get references in the buffer, ordered by priority
				providers = {
					"lsp",
					"treesitter",
					--	"regex",
				},
				-- delay: delay in milliseconds
				delay = 180,
				-- filetype_overrides: filetype specific overrides.
				-- The keys are strings to represent the filetype while the values are tables that
				-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
				filetype_overrides = {},
				-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
				},
				-- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
				-- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
				filetypes_allowlist = {},
				-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
				-- See `:help mode()` for possible values
				modes_denylist = {},
				-- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
				-- See `:help mode()` for possible values
				modes_allowlist = {},
				-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_denylist = {},
				-- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_allowlist = {},
				-- under_cursor: whether or not to illuminate under the cursor
				under_cursor = true,
				-- large_file_cutoff: number of lines at which to use large_file_config
				-- The `under_cursor` option is disabled when this cutoff is hit
				large_file_cutoff = nil,
				-- large_file_config: config to use for large files (based on large_file_cutoff).
				-- Supports the same keys passed to .configure
				-- If nil, vim-illuminate will be disabled for large files.
				large_file_overrides = nil,
				-- min_count_to_highlight: minimum number of matches required to perform highlighting
				min_count_to_highlight = 1,
				-- should_enable: a callback that overrides all other settings to
				-- enable/disable illumination. This will be called a lot so don't do
				-- anything expensive in it.
				should_enable = function(bufnr)
					return true
				end,
				-- case_insensitive_regex: sets regex case sensitivity
				case_insensitive_regex = false,
			})
		end,
	},
}
