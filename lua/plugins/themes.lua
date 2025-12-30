return {
    -- Kanagawa Theme settings
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- Default options:
            require("kanagawa").setup({
                compile = false, -- enable compiling the colorscheme
                undercurl = true,
                commentStyle = { italic = false },
                functionStyle = {},
                statementStyle = { italic = true },
                keywordStyle = { italic = true },
                typeStyle = {},
                transparent = not vim.g.neovide,
                dimInactive = false,
                terminalColors = false,
                colors = {
                    palette = {},
                    theme = {
                        wave = {},
                        lotus = {},
                        dragon = {},
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
                overrides = function(colors)
                    -- found in : ~.local/share/nvim/lazy/kanagawa.nvim/lua/kanagawa/colors.lua
                    local theme = colors.theme
                    local palette = colors.palette
                    return {
                        NormalFloat = { bg = "none" },
                        Pmenu = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        FloatFooter = { bg = "none" },
                        WinSeparator = { fg = palette.lotusInk1, bg = "none" },
                        Visual = { bg = palette.sumiInk5 },
                        Comment = { fg = "#7F7E7C" }, -- Slightly brighter than default (fujiGray)
                        Search = { bg = palette.waveBlue2 },
                        CurSearch = { bg = palette.waveBlue2 },

                        -- Syntax customizations
                        Identifier = { fg = palette.fujiWhite },
                        -- Identifier = { fg = "#ff0000" }, -- for issue example in github
                        ["@variable.parameter"] = { fg = palette.surimiOrange },
                        ["@variable"] = { fg = palette.carpYellow },
                        Constant = { fg = palette.carpYellow },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = "none", fg = theme.ui.fg },
                        MasonNormal = { bg = "none", fg = theme.ui.fg },
                        BlinkCmpMenu = { fg = palette.lotusInk1, bg = "none" },
                        BlinkCmpMenuBorder = { fg = palette.sumiInk6, bg = "none" },
                        BlinkCmpMenuSelection = { fg = "#DBD7BA", bg = "#363646" },
                        BlinkCmpScrollBarThumb = { fg = palette.sumiInk6, bg = palette.lotusInk1 },

                        -- Multicursor colors
                        VM_Insert = { link = "CursorLine" }
                    }
                end,
                theme = "wave", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "wave", -- try "dragon" !
                    light = "lotus",
                },
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")

            -- I personally like a slightly different color for my
            -- background, so I override it here, if neovide
            if vim.g.neovide then
                vim.cmd([[
                    colorscheme kanagawa
                    highlight Normal guibg=#191E25
                ]])
            end
        end,
    },
}
