return {
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			variant = "dark",
			-- Some defaults were a bit too dark for my taste, so overriding
			-- to something with better contrast.
			override_by_extension = {
				["tsx"] = {
					icon = "",
					color = "#62d5e9",
					name = "React",
				},
				["jsx"] = {
					icon = "",
					color = "#62d5e9",
					name = "React",
				},
				["css"] = {
					icon = "",
					color = "#a568e4",
					name = "CSS",
				},
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					normal_hl = "Comment", -- Base highlight group in the notification window
					winblend = 0, -- Background color opacity in the notification window
					border = "none", -- Border around the notification window
					zindex = 45, -- Stacking priority of the notification window
					max_width = 0, -- Maximum width of the notification window
					max_height = 0, -- Maximum height of the notification window
					x_padding = 1, -- Padding from right edge of window boundary
					y_padding = 1, -- Padding from bottom edge of window boundary
					align = "bottom", -- How to align the notification window
					relative = "editor", -- What the notification window position is relative to
				},
				override_vim_notify = true,
			},
		},
	},
}
