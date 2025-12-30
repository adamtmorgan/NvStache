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
    end,
}
