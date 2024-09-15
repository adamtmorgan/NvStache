----------------------------------------------------
---Defines custom status line
----------------------------------------------------

-- Status line config ------------------------------
return {
	"rebelot/heirline.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
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
			gray = "#60687e",
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
		local visual_block_string = "󰡫 VBLOCK"
		local visual_row_string = "󰡭 VISROW"
		local select_string = "󰒅 SELECT"
		local insert_string = " INSERT"
		local replace_string = "󰯍 REPLACE"
		local command_string = " COMMAND"
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
			V = visual_row_string,
			Vs = visual_string,
			["\22"] = visual_block_string,
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
						return { fg = self.color_primpary, bg = "none" }
					end,
				},
				{
					ViModeText,
					hl = function(self)
						return { fg = colors.background, bg = self.color_primpary, bold = true }
					end,
				},
				{
					provider = "",
					hl = function(self)
						return { fg = self.color_primpary, bg = "none" }
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
				return { fg = self.color_primpary }
			end,

			{ -- git branch name
				provider = function(self)
					return "   " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			-- You could handle delimiters, icons and counts similar to Diagnostics
			-- {
			-- 	condition = function(self)
			-- 		return self.has_changes
			-- 	end,
			-- 	provider = "(",
			-- },
			-- {
			-- 	provider = function(self)
			-- 		local count = self.status_dict.added or 0
			-- 		return count > 0 and ("+" .. count)
			-- 	end,
			-- 	hl = { fg = colors.green },
			-- },
			-- {
			-- 	provider = function(self)
			-- 		local count = self.status_dict.removed or 0
			-- 		return count > 0 and ("-" .. count)
			-- 	end,
			-- 	hl = { fg = colors.red },
			-- },
			-- {
			-- 	provider = function(self)
			-- 		local count = self.status_dict.changed or 0
			-- 		return count > 0 and ("~" .. count)
			-- 	end,
			-- 	hl = { fg = colors.yellow },
			-- },
			-- {
			-- 	condition = function(self)
			-- 		return self.has_changes
			-- 	end,
			-- 	provider = ")",
			-- },
		}

		local Align = { provider = "%=" }

		----------------------------------------------------
		--- Make buffer list
		----------------------------------------------------

		local FileIcon = {
			init = function(self)
				local filename = self.file_name
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (" " .. self.icon .. " ")
			end,
			hl = function(self)
				if self.is_active and self.mode_cat ~= "n" then
					return { fg = self.color_primary }
				elseif self.is_active and self.mode_cat == "n" then
					return { fg = self.icon_color }
				else
					return { fg = colors.gray }
				end
			end,
		}

		local BufferFileName = {
			provider = function(self)
				return self.file_name .. " "
			end,
		}

		local Buffer = {
			init = function(self)
				self.file_name_path = vim.api.nvim_buf_get_name(self.bufnr)
				self.file_name = self.file_name_path:match("^.+/(.+)$")
				if self.file_name == nil then
					self.file_name = vim.api.nvim_buf_get_option(self.bufnr, "buftype")
				end
			end,
			-- condition = function(self)
			-- 	return self.file_name ~= nil
			-- end,
			FileIcon,
			BufferFileName,
			on_click = {
				callback = function(_, minwid, _, button)
					if button == "m" then -- close on mouse middle click
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
						end)
					else
						vim.api.nvim_win_set_buf(0, minwid)
					end
				end,
				minwid = function(self)
					return self.bufnr
				end,
				name = "heirline_tabline_buffer_callback",
			},
			hl = function(self)
				if self.is_active then
					return { fg = self.color_primpary }
				else
					return { fg = colors.gray }
				end
			end,
		}

		local Buffers = utils.make_buflist(
			Buffer,
			{ provider = "…", hl = { fg = colors.gray } },
			{ provider = "…", hl = { fg = colors.gray } }
		)

		----------------------------------------------------
		--- Cursor position and scrollbar
		----------------------------------------------------

		local LeftArrow = {
			provider = "   ",
			hl = { fg = colors.gray },
		}

		-- We're getting minimalist here!
		local Position = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window
			provider = "%7(%l/%3L%):%2c  %P",
			hl = function(self)
				return { fg = self.color_primpary }
			end,
		}

		----------------------------------------------------
		--- Status line assembly
		----------------------------------------------------

		local Left = {
			ViModeSection,
			Git,
			LeftArrow,
			Buffers,
		}

		local Right = {
			Position,
		}

		-- Main line computes colors based on mode for child
		-- components to reference via `self`
		local MainLine = {
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
				self.mode_cat = self.mode:sub(1, 1) -- first char only
				self.color_primpary = mode_colors[self.mode_cat]
			end,
			-- Watch below closely... Performance could suck and this will
			-- need to be changed:
			-- update = { "BufAdd", "BufEnter", "BufLeave", "ModeChanged" },
			Left,
			-- Align,
			-- Center,
			Align,
			Right,
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
