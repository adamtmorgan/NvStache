return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Set up theme changes
		local lualine_theme = require("lualine.themes.auto")
		-- Override specific sections to make the background transparent
		lualine_theme.normal.c.bg = "none"
		lualine_theme.inactive.c.bg = "none"

		local section_separator_left = ""
		local section_separator_right = ""
		local component_separator_left = ""
		local component_separator_right = ""

		require("lualine").setup({
			options = {
				icons_enabled = true,
				-- theme = "auto", -- You can change this to any theme you prefer
				theme = lualine_theme,
				-- section_separators = { left = section_separator_left, right = section_separator_right },
				-- componenet_separators = { left = component_separator_left, right = component_separator_right },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							local mode_icon = "󱗞 " -- Stache icon for memes
							return mode_icon .. str
						end,
						separator = { left = section_separator_left, right = section_separator_right },
					},
				},
				lualine_b = {
					{
						"branch",
						separator = {
							left = section_separator_left,
							right = "",
						},
					},
				},
				lualine_c = {
					{
						"buffers",
						show_filename_only = true,
						hide_filename_extension = false, -- Don't hide file extensions
						show_modified_status = true, -- Show if the file is modified

						mode = 0,
						-- 0: Shows buffer name
						-- 1: Shows buffer index
						-- 2: Shows buffer name + buffer index
						-- 3: Shows buffer number
						-- 4: Shows buffer name + buffer number

						max_length = vim.o.columns * 2 / 3, -- Maximum width  buffers component
						filetype_names = {
							TelescopePrompt = "Telescope",
							dashboard = "Dashboard",
							fzf = "FZF",
							alpha = "Alpha",
						},
						-- use_mode_colors = true,
						buffers_color = {
							active = "lualine_a_normal", -- Color for active buffer
							inactive = { fg = "#8DA3CF", bg = "#323948" }, -- Color for inactive buffer
						},
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							-- alternate_file = "#", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
						separator = { right = section_separator_right },
					},
				},
				lualine_x = { "diff", "encoding", "filetype" },
				lualine_y = { "progress" },
				lualine_z = {
					{
						"location",
						separator = { left = section_separator_left, right = section_separator_right },
					},
				},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
