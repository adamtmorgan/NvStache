-- Make sure to disable Ctl<up> and Ctl<down> bindings in MacOS
-- if you haven't already. Using default bindings.
return {
    "mg979/vim-visual-multi",
    config = function()
        vim.g.VM_silent_exit = 1
        vim.keymap.set(
            { "n" },
            "<c-k>",
            ":call vm#commands#add_cursor_up(0, v:count1)<cr>",
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            { "n" },
            "<c-j>",
            ":call vm#commands#add_cursor_down(0, v:count1)<cr>",
            { noremap = true, silent = true }
        )

        -- NOTE: Hack that fixes bug that prevents blink cmp accept from working
        -- after exiting VM. Might be able to remove if the fix is merged later.
        -- https://github.com/mg979/vim-visual-multi/issues/291#issuecomment-3067070036
        -- https://github.com/mg979/vim-visual-multi/pull/297 - supposedly fixes the issue.
        vim.api.nvim_create_autocmd("User", {
            pattern = "visual_multi_exit",
            callback = function()
                local cmp = require("blink.cmp")
                vim.keymap.set("i", "<CR>", function()
                    if cmp.is_visible() then
                        cmp.accept()
                        return ""
                    else
                        return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
                    end
                end, { expr = true, silent = true })
            end,
        })
    end,
}
