return {
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
       end,
    },
    {
        "kevinhwang91/nvim-hlslens",
         config = function()
        -- require('hlslens').setup() is not required
        require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
        })
        end,
    }
}
