return {
	--------------------------------------------------
	-- Handles the popup window for autocomplete
	--------------------------------------------------
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			completion = {
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				menu = {
					border = "rounded",
				},
				documentation = {
					window = {
						border = "rounded",
					},
					auto_show = true,
					auto_show_delay_ms = 0,
				},
				ghost_text = {
					enabled = true,
				},
				trigger = {
					show_on_trigger_character = true,
				},
			},

			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},

			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = "enter",
				["<C-k>"] = { "select_prev" },
				["<C-j>"] = { "select_next" },
				["<C-u>"] = { "scroll_documentation_up" },
				["<C-d>"] = { "scroll_documentation_down" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			cmdline = {
				completion = {
					menu = { auto_show = true },
					list = {
						selection = { preselect = false, auto_insert = false },
					},
				},
				keymap = {
					preset = "enter",
					["<C-k>"] = { "select_prev" },
					["<C-j>"] = { "select_next" },
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"avante_commands",
					"avante_mentions",
					"avante_files",
				},
				providers = {
					avante_commands = {
						name = "avante_commands",
						module = "blink.compat.source",
						score_offset = 90, -- show at a higher priority than lsp
						opts = {},
					},
					avante_files = {
						name = "avante_files",
						module = "blink.compat.source",
						score_offset = 100, -- show at a higher priority than lsp
						opts = {},
					},
					avante_mentions = {
						name = "avante_mentions",
						module = "blink.compat.source",
						score_offset = 1000, -- show at a higher priority than lsp
						opts = {},
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	--------------------------------------------------
	-- Handles LSP as source for completions
	--------------------------------------------------
	-- NOTE: keep this in mind for later:
	-- https://cmp.saghen.dev/configuration/signature.html#signature
	-- Testing blink.cmp to see if it can replace this. Keeping details
	-- here in the meantime just in case I need to revert.
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	config = function()
	-- 		require("lsp_signature").setup({
	-- 			bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- 			handler_opts = {
	-- 				border = "rounded",
	-- 			},
	-- 			floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
	-- 			hint_enable = true, -- virtual hint enable
	-- 			hint_prefix = "󰛨 ", -- Panda for parameter hint
	-- 			hi_parameter = "Search", -- Highlight for current parameter
	-- 		})
	-- 	end,
	-- },
}
