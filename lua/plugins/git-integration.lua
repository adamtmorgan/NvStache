-- Shows inline git blame
return {
    -- Shows git signs in editor
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
}
