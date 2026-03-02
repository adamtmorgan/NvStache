return {
    -- Maps nerdfont icons and colors to associated lsps, filetypes,
    -- languages, etc. Used in lots of other dependencies and also
    -- directly in the statusline config.
    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            variant = "dark",
            override_by_extension = {
                ["tsx"] = {
                    icon = "",
                    color = "#62d5e9",
                    name = "React",
                },
                ["jsx"] = {
                    icon = "",
                    color = "#62d5e9",
                    name = "React",
                },
                ["css"] = {
                    icon = "",
                    color = "#a568e4",
                    name = "CSS",
                },
            },
        },
    },

    {
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "petertriho/nvim-scrollbar",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "lewis6991/gitsigns.nvim", "kevinhwang91/nvim-hlslens" },
        config = function()
            require("scrollbar").setup({
                excluded_buftypes = {
                    "terminal",
                },
                excluded_filetypes = {
                    "dropbar_menu",
                    "dropbar_menu_fzf",
                    "DressingInput",
                    "cmp_docs",
                    "cmp_menu",
                    "noice",
                    "prompt",
                    "TelescopePrompt",
                    "blink-cmp",
                    "blink-cmp-menu",
                    "blink-cmp-signature",
                    "blink-cmp-documentation",
                },
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = true,
                    handle = true,
                    search = true,
                },
                handle = {
                    color = "#56576f",
                },
                marks = {
                    Cursor = {
                        text = "◆",
                        priority = 0,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil,
                        highlight = "Normal",
                    },
                },
            })
        end,
    },

    {
        "kevinhwang91/nvim-hlslens",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("scrollbar.handlers.search").setup({})
        end,
    },

    {
        "RRethy/vim-illuminate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                },
                delay = 180,
                filetype_overrides = {},
                filetypes_denylist = {
                    "dirbuf",
                    "dirvish",
                },
                under_cursor = true,
            })
        end,
    },
}
