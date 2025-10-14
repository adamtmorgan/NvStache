-- local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

-- Utils

local function get_visual_or_word()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_row, start_col = start_pos[2], start_pos[3]
    local end_row, end_col = end_pos[2], end_pos[3]

    if start_row ~= 0 and end_row ~= 0 then
        local lines = vim.fn.getline(start_row, end_row)
        if type(lines) ~= "table" then
            lines = { tostring(lines) }
        end

        if #lines == 1 then
            lines[1] = string.sub(tostring(lines[1]), start_col, end_col)
        else
            lines[1] = string.sub(tostring(lines[1]), start_col)
            lines[#lines] = string.sub(tostring(lines[#lines]), 1, end_col)
        end

        return table.concat(lines, " ")
    end

    -- Fallback: word under cursor
    vim.api.nvim_command('normal! "zyiw')
    return vim.fn.getreg("z")
end

--------------------------------------------------
-- Console Log shortcut
--------------------------------------------------

local function shotcut_console_log()
    local handlers = {
        javascript = function(selected_text)
            return 'normal! oconsole.log("' .. selected_text .. '", ' .. selected_text .. ");"
        end,
        typescript = function(selected_text)
            return 'normal! oconsole.log("' .. selected_text .. '", ' .. selected_text .. ");"
        end,
        javascriptreact = function(selected_text)
            return 'normal! oconsole.log("' .. selected_text .. '", ' .. selected_text .. ");"
        end,
        typescriptreact = function(selected_text)
            return 'normal! oconsole.log("' .. selected_text .. '", ' .. selected_text .. ");"
        end,
    }

    local filetype = vim.bo.filetype
    if handlers[filetype] then
        local selected_text = get_visual_or_word()
        if selected_text ~= "" then
            vim.api.nvim_command(handlers[filetype](selected_text))
        end
    end
end

vim.api.nvim_create_user_command("ShortcutConsoleLog", shotcut_console_log, { range = true })
vim.keymap.set("n", "<leader>ml", ":ShortcutConsoleLog<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ml", ":ShortcutConsoleLog<CR>", { noremap = true, silent = true })
