return {
    -- Maps nerdfont icons and colors to associated lsps, filetypes,
    -- languages, etc. Used in lots of other dependencies and also
    -- directly in the statusline config.
    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            variant = "dark",
            -- Some defaults were a bit too dark for my taste, so overriding
            -- to something with better contrast.
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

    -- Detects hex colors in-editor and sets background highlight to match
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    -- Highlights todo, fix ,warn, and other tags in comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- For scrollbar. Use with gitsigns to show git changes
    -- in project.
    {
        "petertriho/nvim-scrollbar",
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
                    gitsigns = false, -- Requires gitsigns
                    handle = true,
                    search = true, -- Requires hlslens
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
                        color_nr = nil, -- cterm
                        highlight = "Normal",
                    },
                },
            })
        end,
    },

    -- For better glancing at matched info in searches
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            -- require('hlslens').setup() is not required
            require("scrollbar.handlers.search").setup({
                -- hlslens config overrides
            })
        end,
    },

    -- Highlights symbol under the caret throughout the
    -- document
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    "lsp",
                    "treesitter",
                    --	"regex",
                },
                delay = 180,
                filetype_overrides = {},
                filetypes_denylist = {
                    "dirbuf",
                    "dirvish",
                    "fugitive",
                },
                under_cursor = true,
            })
        end,
    },
}
