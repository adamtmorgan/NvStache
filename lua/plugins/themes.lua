return {
	-- Kanagawa Theme settings
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Default options:
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = false },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = not vim.g.neovide, -- bg is not set uniless neovide
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						lotus = {},
						dragon = {},
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors) -- add/modify highlights
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						Visual = { bg = "#363646" },
						-- TODO: Below not working for some reason
						-- VertSplit = { fg = "#54546D", bg = "none" },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

						TelescopePromptNormal = { bg = "none" },
						TelescopePromptBorder = { fg = theme.ui.fg_dim, bg = "none" },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
						TelescopeResultsBorder = { fg = theme.ui.fg_dim, bg = "none" },
						TelescopePreviewNormal = { bg = "none" },
						TelescopePreviewBorder = { bg = "none", fg = theme.ui.fg_dim },

						-- Blink.cmp
						BlinkCmpMenu = { fg = "#54546D", bg = "none" },
						BlinkCmpMenuBorder = { fg = "#54546D", bg = "none" },
						BlinkCmpMenuSelection = { fg = "#DBD7BA", bg = "#363646" },
						BlinkCmpScrollBarThumb = { fg = "#54546D", bg = "#54546D" },
					}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})

			-- setup must be called before loading
			vim.cmd("colorscheme kanagawa")

			-- I personally like a slightly different color for my
			-- background, so I override it here, if neovide
			if vim.g.neovide then
				vim.cmd([[
				  colorscheme kanagawa
				  highlight Normal guibg=#191E25
				]])
			end
		end,
	},
}
