return {
	-- {
	-- 	"Fildo7525/pretty_hover",
	-- 	event = "LspAttach",
	-- 	opts = {},
	-- },
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
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")

			notify.setup({
				render = "wrapped-compact",
				fps = 60,
			})

			vim.notify = function(msg, level)
				-- Define a list of messages or patterns to silence
				local silenced_patterns = {
					-- "No information available",
				}

				for _, pattern in ipairs(silenced_patterns) do
					if msg:match(pattern) then
						return
					end
				end

				notify(msg, level)
			end
		end,
	},
}
