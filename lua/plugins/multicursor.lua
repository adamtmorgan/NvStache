-- Make sure to disable Ctl<up> and Ctl<down> bindings in MacOS
-- if you haven't already. Using default bindings.
return {
    "mg979/vim-visual-multi",
    config = function()
        vim.g.VM_silent_exit = 1
    end,
}
