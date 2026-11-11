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
        branch = "refactor/v2",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "lewis6991/gitsigns.nvim" },
        config = function()
            require("scrollbar").setup({
                exclude = {
                    buftypes = {
                        terminal = true,
                    },
                    filetypes = {
                        dropbar_menu = true,
                        dropbar_menu_fzf = true,
                        DressingInput = true,
                        cmp_docs = true,
                        cmp_menu = true,
                        noice = true,
                        prompt = true,
                        TelescopePrompt = true,
                        ["blink-cmp"] = true,
                        ["blink-cmp-menu"] = true,
                        ["blink-cmp-signature"] = true,
                        ["blink-cmp-documentation"] = true,
                    },
                },
                providers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = true,
                    search = true,
                },
                marks = {
                    Cursor = {
                        text = "◆",
                        priority = 0,
                        highlight = "Normal",
                    },
                },
                scrollbar = {
                    thumb = {
                        highlight = { bg = "#56576f" },
                    },
                },
            })
        end,
    },

    {
        "kevinhwang91/nvim-hlslens",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
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
