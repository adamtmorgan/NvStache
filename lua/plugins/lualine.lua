return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Set up theme changes
		local lualine_theme = require("lualine.themes.auto")
		-- Override specific sections to make the background transparent
		lualine_theme.normal.c.bg = "none"
		lualine_theme.inactive.c.bg = "none"

		require("lualine").setup({
			options = {
				icons_enabled = true,
				-- theme = "auto", -- You can change this to any theme you prefer
				theme = lualine_theme,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							local mode_icon = "󱗞 " -- Stache icon for memes
							return mode_icon .. str
						end,
					},
				},
				lualine_b = { "branch" },
				lualine_c = {
					{
						"buffers",
						show_filename_only = true,
						hide_filename_extension = false, -- Don't hide file extensions
						show_modified_status = true, -- Show if the file is modified

						mode = 0, -- 0: Shows buffer name
						-- 1: Shows buffer index
						-- 2: Shows buffer name + buffer index
						-- 3: Shows buffer number
						-- 4: Shows buffer name + buffer number

						max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component
						filetype_names = {
							TelescopePrompt = "Telescope",
							dashboard = "Dashboard",
							packer = "Packer",
							fzf = "FZF",
							alpha = "Alpha",
						},
						use_mode_colors = true,
						buffers_color = {
							active = "lualine_a_normal", -- Color for active buffer
							inactive = { fg = "#8DA3CF", bg = "#323948" }, -- Color for inactive buffer
						},
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							-- alternate_file = "#", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
					},
				},
				lualine_x = { "diff", "encoding", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
