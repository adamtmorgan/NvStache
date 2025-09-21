----------------------------------------------------
--Defines custom status line
----------------------------------------------------

-- Config vars that apply to all versions

----------------------------------------------------
--- Utility functions
----------------------------------------------------

local function compute_buffer_path_name(full_path)
    local cwd = vim.fn.getcwd()
    local relative_path = full_path:gsub("^" .. vim.pesc(cwd) .. "/", ""):gsub("^/", "")

    local path_components = {}
    for component in string.gmatch(relative_path, "[^/]+") do
        table.insert(path_components, component)
    end

    local max_path_size = 3
    local trimmed_path = ""

    if #path_components > max_path_size then
        trimmed_path = ".../"
    end

    local start_index = math.max(1, #path_components - max_path_size + 1)

    for i = start_index, #path_components - 1 do
        trimmed_path = trimmed_path .. path_components[i] .. "/"
    end

    local filename = path_components[#path_components] or relative_path

    return trimmed_path, filename
end

local function buffer_count()
    local count = 0
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.fn.buflisted(bufnr) == 1 then
            count = count + 1
        end
    end
    return count
end

----------------------------------------------------
--- Define Tables for colors and vim modes
----------------------------------------------------

local colors = {
    background = "#1c2129",
    gray = "#60687e",
    dark_gray = "#3b3d4e",
    white = "#E2DCC0",
    blue = "#80A7E0",
    green = "#9DC472",
    yellow = "#EEC789",
    orange = "#FFA570",
    red = "#F76880",
    purple = "#b196d4",
}

local normal_string = "󱗞 NORMAL"
local visual_string = "󰈈 VISUAL"
local visual_block_string = "󰡫 VBLOCK"
local visual_row_string = "󰡭 VISROW"
local select_string = "󰒅 SELECT"
local insert_string = " INSERT"
local replace_string = "󰯍 REPLACE"
local terminal = "  TERM "
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
    t = terminal,
}

local SpecialBuffers = {
    snacks_picker_input = {
        icon = " ",
        name = "Snacks Picker",
        color = colors.blue,
    },
    snacks_picker_list = {
        icon = " ",
        name = "Snacks Picker",
        color = colors.blue,
    },
    oil = {
        icon = " ",
        name = "Oil",
        color = colors.blue,
    },
    toggleterm = {
        icon = " ",
        name = "Terminal",
        color = colors.red,
    },
    unknown = {
        icon = " ",
    },
}

return {
    "rebelot/heirline.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "lewis6991/gitsigns.nvim" },
    },
    -- You can optionally lazy-load heirline on UiEnter
    -- to make sure all required plugins and colorschemes are loaded before setup
    -- event = "UiEnter",
    config = function()
        local heirline = require("heirline")
        local utils = require("heirline.utils")
        local conditions = require("heirline.conditions")
        local web_devicons = require("nvim-web-devicons")

        ----------------------------------------------------
        --- Main Segments
        ----------------------------------------------------

        local function CreateSection(component, direction, is_end, condition)
            local surrounds = { "█", "█" }
            if is_end and direction == "right" then
                surrounds = { "█", "" }
            elseif is_end and direction == "left" then
                surrounds = { "", "█" }
            elseif direction == "right" then
                surrounds = { "█", "█" }
            elseif direction == "center" then
                surrounds = { "█", "█" }
            elseif direction == "standalone" then
                surrounds = { "", "" }
            end

            return {
                condition = condition,
                utils.surround(surrounds, function(self)
                    return self.section_background
                end, {
                    hl = function(self)
                        return { fg = self.bg_color, bg = self.section_background, bold = true }
                    end,
                    component,
                }),
            }
        end

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
                    provider = "█",
                    hl = function(self)
                        return { fg = self.color_primpary }
                    end,
                },
            },
            update = {
                "ModeChanged",
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

        local GitChanges = {
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
                hl = function(self)
                    if self.mode_cat == "n" then
                        return { fg = colors.green }
                    else
                        return { fg = self.color_primary }
                    end
                end,
            },
            {
                provider = function(self)
                    local count = self.status_dict.removed or 0
                    return count > 0 and ("-" .. count)
                end,
                hl = function(self)
                    if self.mode_cat == "n" then
                        return { fg = colors.red }
                    else
                        return { fg = self.color_primary }
                    end
                end,
            },
            {
                provider = function(self)
                    local count = self.status_dict.changed or 0
                    return count > 0 and ("~" .. count)
                end,
                hl = function(self)
                    if self.mode_cat == "n" then
                        return { fg = colors.orange }
                    else
                        return { fg = self.color_primary }
                    end
                end,
            },
            {
                condition = function(self)
                    return self.has_changes
                end,
                provider = ")",
            },
        }

        local Git = {
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
                    return " " .. self.status_dict.head
                end,
                hl = { bold = true },
            },
            GitChanges,
        }

        local Align = { provider = "%=" }

        ----------------------------------------------------
        --- Make buffer list
        ----------------------------------------------------

        local FileIcon = {
            init = function(self)
                local filename = self.file_name_path
                local extension = vim.fn.fnamemodify(filename, ":e")
                if self.override_icon == nil then
                    self.icon, self.icon_color =
                        web_devicons.get_icon_color(filename, extension, { default = true, variant = "light" })
                end
            end,
            provider = function(self)
                local rendered_icon = self.override_icon or self.icon
                return rendered_icon and (rendered_icon .. " ")
            end,
            hl = function(self)
                if self.mode_cat == "n" then
                    return { fg = self.override_icon_color or self.icon_color }
                else
                    return { fg = self.color_primary }
                end
            end,
        }

        local BufferPathname = {
            condition = function(self)
                return self.path_name ~= nil
            end,
            provider = function(self)
                return self.path_name
            end,
            hl = { bold = false },
        }

        local BufferFileName = {
            provider = function(self)
                return self.file_name
            end,
            hl = { bold = true },
        }

        local ActiveBuffer = {
            init = function(self)
                self.buff_type = string.lower(vim.bo.filetype)
                self.file_name_path = vim.api.nvim_buf_get_name(0)

                local special_buffer = SpecialBuffers[string.lower(vim.bo.filetype)]
                if special_buffer ~= nil then
                    self.file_name = special_buffer.name
                    self.override_icon = special_buffer.icon
                    self.override_icon_color = special_buffer.color
                else
                    self.path_name, self.file_name = compute_buffer_path_name(self.file_name_path)
                    self.override_icon = nil
                    self.override_icon_color = nil
                end

                if self.file_name == nil then
                    self.file_name = vim.api.nvim_buf_get_option(self.file_name_path, "buftype")
                end
            end,
            -- condition = function(self)
            -- 	return self.file_name ~= nil
            -- end,
            FileIcon,
            BufferPathname,
            BufferFileName,
            hl = function(self)
                return { fg = self.color_primpary }
            end,
            update = {
                "BufEnter",
                "BufLeave",
                "ModeChanged",
            },
        }

        local OpenBuffersCount = {
            {
                provider = function()
                    local count = buffer_count()
                    return " " .. count .. " "
                end,
                hl = function(self)
                    return { fg = self.color_primpary }
                end,
                update = {
                    "VimEnter",
                    "BufAdd",
                    "BufDelete",
                    "BufFilePost",
                    "BufNew",
                    "ModeChanged",
                },
            },
        }

        local FileType = {
            init = function(self)
                self.filetype = string.lower(vim.bo.filetype)
                self.icon, self.icon_color = web_devicons.get_icon_colors_by_filetype(self.filetype)
                self.color_primary = self.color_primary
            end,
            {
                provider = function(self)
                    return self.icon and (self.icon .. " ")
                end,
                hl = function(self)
                    if self.mode_cat == "n" then
                        return { fg = self.icon_color }
                    else
                        return { fg = self.color_primary }
                    end
                end,
            },
            {
                provider = function(self)
                    return self.filetype
                end,

                hl = function(self)
                    return { fg = self.color_primary }
                end,
            },
        }

        local LSPActive = {
            condition = conditions.lsp_attached,
            provider = function()
                local names = {}
                for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    table.insert(names, server.name)
                end
                return " [" .. table.concat(names, ",") .. "]"
            end,

            hl = function(self)
                return { fg = self.color_primpary, bold = false }
            end,
        }

        local FileTypeLsp = {
            FileType,
            LSPActive,
            hl = function(self)
                return { fg = self.color_primpary }
            end,
        }

        ----------------------------------------------------
        --- Cursor position and scrollbar
        ----------------------------------------------------

        local Position = {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            provider = "%7(%l/%3L%):%2c  %P ",
            hl = function(self)
                return { fg = self.color_primpary }
            end,
            update = {
                "ModeChanged",
            },
        }

        ----------------------------------------------------
        --- Status line assembly
        ----------------------------------------------------

        local Left = {
            init = function(self)
                self.section_background = colors.dark_gray
            end,
            ViModeSection,
            CreateSection(Git, "left", false, conditions.is_git_repo),
            -- CreateSection(ActiveBuffer),
        }

        local Right = {
            init = function(self)
                self.section_background = colors.dark_gray
            end,
            CreateSection(FileTypeLsp, "left", false, conditions.lsp_attached),
            CreateSection(Position, "center"),
            CreateSection(OpenBuffersCount, "right", true),
            update = { "BufEnter", "BufLeave", "ModeChanged", "LspAttach", "LspDetach" },
        }

        -- Main line computes colors based on mode for child
        -- components to reference via `self`
        local MainLine = {
            init = function(self)
                self.mode = vim.fn.mode(1) -- :h mode()
                self.mode_cat = self.mode:sub(1, 1) -- first char only
                self.color_primpary = mode_colors[self.mode_cat]
            end,
            Align,
            Left,
            Right,
            Align,
            -- NOTE: Might need to optimize later, but for now updating on every change seems to be performant enough.
            -- update = { "BufEnter", "BufLeave", "ModeChanged", "TextChanged", "TextYankPost" },
        }

        -- Full Status line
        local StatusLine = { hl = { bg = "none" }, { MacroRec, MainLine } }

        -- Winbar (shows at top of each split)
        local WinBar = {
            -- fallthrough = false,
            update = { "BufEnter", "BufLeave", "ModeChanged" },
            init = function(self)
                self.section_background = colors.dark_gray
                self.mode = vim.fn.mode(1) -- :h mode()
                self.mode_cat = self.mode:sub(1, 1) -- first char only
                self.color_primpary = mode_colors[self.mode_cat]
            end,
            hl = { bg = "none" },
            -- Inactive buffers
            Align,
            {
                condition = function()
                    return not conditions.is_active()
                end,
                CreateSection({
                    ActiveBuffer,
                    {
                        condition = function()
                            return not vim.bo.modifiable or vim.bo.readonly
                        end,
                        provider = "",
                        hl = { fg = "orange" },
                    },
                }, "standalone"),
            },
            -- Active buffer
            {
                condition = function()
                    return conditions.is_active()
                end,
                CreateSection(ActiveBuffer, "standalone"),
            },
            Align,
        }

        -- Make status line background transparent so heirline can take over.
        vim.cmd([[
		  highlight StatusLine ctermbg=NONE guibg=NONE
		  highlight StatusLineNC ctermbg=NONE guibg=NONE
		]])

        heirline.setup({
            statusline = StatusLine,
            winbar = WinBar,
            opts = {
                colors = colors,
                disable_winbar_cb = function(args)
                    if vim.api.nvim_buf_is_valid(args.buf) then
                        return conditions.buffer_matches({
                            buftype = { "index", "nofile", "acwrite", "prompt", "help", "quickfix", "terminal", "oil" },
                            filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
                        }, args.buf)
                    else
                        return true
                    end
                end,
            },
        })
    end,
}
