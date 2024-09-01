----------------------------------------------------
---Defines custom status line
----------------------------------------------------

-- Status line config ------------------------------

return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	-- event = "UiEnter",
	config = function()
		local heirline = require("heirline")
		local utils = require("heirline.utils")
		local conditions = require("heirline.conditions")

		----------------------------------------------------
		--- Define Tables for colors and vim modes
		----------------------------------------------------

		local colors = {
			background = "#1c2129",
			gray = "#3D3E50",
			dark_gray = "#0D1117",
			white = "#E2DCC0",
			blue = "#80A7E0",
			green = "#9DC472",
			yellow = "#EEC789",
			orange = "#FFA570",
			red = "#F76880",
			purple = "#A289C2",
		}

		local normal_string = "󱗞 NORMAL"
		local visual_string = "󰈈 VISUAL"
		local select_string = "󰒅 SELECT"
		local insert_string = " INSERT"
		local replace_string = "󰯍 REPLACE"
		local command_string = " REPLACE"
		local ex_string = " EXECUTE"
		local debug_string = " DEBUG"

		-- Mode colors map
		local mode_colors = {
			n = colors.white,
			i = colors.green,
			v = colors.purple,
			V = colors.purple,
			["\22"] = colors.purple,
			c = colors.orange,
			s = colors.purple,
			S = colors.purple,
			["\19"] = colors.purple,
			R = colors.orange,
			r = colors.orange,
			["!"] = colors.red,
			t = colors.red,
		}

		local mode_names = { -- change the strings if you like it vvvvverbose!
			-- Normal
			n = normal_string,
			no = normal_string,
			nov = normal_string,
			noV = normal_string,
			["no\22"] = normal_string,
			niI = normal_string,
			niR = normal_string,
			niV = normal_string,
			nt = normal_string,
			v = visual_string,
			vs = visual_string,
			V = visual_string,
			Vs = visual_string,
			["\22"] = visual_string,
			["\22s"] = visual_string,
			s = select_string,
			S = select_string,
			["\19"] = select_string,
			i = insert_string,
			ic = insert_string,
			ix = insert_string,
			R = replace_string,
			Rc = replace_string,
			Rx = replace_string,
			Rv = replace_string,
			Rvc = replace_string,
			Rvx = replace_string,
			c = command_string,
			cv = ex_string,
			r = debug_string,
			rm = debug_string,
			["r?"] = "?",
			["!"] = "!",
			t = "T",
		}

		----------------------------------------------------
		--- Vim Mode Components
		----------------------------------------------------

		local ViModeText = {
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
			end,
			provider = function(self)
				return mode_names[self.mode]
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		local ViModeSection = {
			{
				{
					provider = "",
					hl = function(self)
						return { fg = self.colorPrimary, bg = "none" }
					end,
				},
				{
					ViModeText,
					hl = function(self)
						return { fg = colors.background, bg = self.colorPrimary, bold = true }
					end,
				},
				{
					provider = "",
					hl = function(self)
						return { fg = self.colorPrimary, bg = "none" }
					end,
				},
			},
		}

		----------------------------------------------------
		--- Component that shows if a macro is recording
		----------------------------------------------------

		local MacroRec = {
			condition = function()
				return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
			end,
			utils.surround({ "", " " }, colors.red, {
				provider = "󰻂 ",
				hl = { fg = colors.background, bold = true },
				utils.surround({ "[", "]" }, nil, {
					provider = function()
						return vim.fn.reg_recording()
					end,
					hl = { bold = true },
				}),
				update = {
					"RecordingEnter",
					"RecordingLeave",
				},
			}),
		}

		----------------------------------------------------
		--- Git
		----------------------------------------------------

		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = function(self)
				return { fg = self.colorPrimary }
			end,

			{ -- git branch name
				provider = function(self)
					return "  " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			-- You could handle delimiters, icons and counts similar to Diagnostics
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "(",
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("+" .. count)
				end,
				hl = { fg = colors.green },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("-" .. count)
				end,
				hl = { fg = colors.red },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("~" .. count)
				end,
				hl = { fg = colors.yellow },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = ")",
			},
		}

		----------------------------------------------------
		--- Status line assembly
		----------------------------------------------------

		-- Main line computes colors based on mode for child
		-- components to reference via `self`
		local MainLine = {
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
				self.modeCat = self.mode:sub(1, 1) -- first char only
				self.colorPrimary = mode_colors[self.modeCat]
			end,
			ViModeSection,
			Git,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		-- Full Status line
		local StatusLine = { hl = { bg = "none" }, { MacroRec, MainLine } }

		-- Make status line background transparent so heirline can take over.
		vim.cmd([[
		  highlight StatusLine ctermbg=NONE guibg=NONE
		  highlight StatusLineNC ctermbg=NONE guibg=NONE
		]])

		heirline.setup({ statusline = StatusLine, ops = { colors = colors } })
	end,
}
