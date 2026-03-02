return {
    --------------------------------------------------
    -- Handles the popup window for autocomplete
    --------------------------------------------------
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            completion = {
                accept = {
                    auto_brackets = { enabled = false },
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                },
                ghost_text = {
                    enabled = true,
                },
                -- https://github.com/brenoprata10/nvim-highlight-colors?tab=readme-ov-file#blinkcmp-integration
                menu = {
                    kind_icon = {
                        text = function(ctx)
                            -- default kind icon
                            local icon = ctx.kind_icon
                            -- if LSP source, check for color derived from documentation
                            if ctx.item.source_name == "LSP" then
                                local color_item =
                                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                if color_item and color_item.abbr ~= "" then
                                    icon = color_item.abbr
                                end
                            end
                            return icon .. ctx.icon_gap
                        end,
                        highlight = function(ctx)
                            -- default highlight group
                            local highlight = "BlinkCmpKind" .. ctx.kind
                            -- if LSP source, check for color derived from documentation
                            if ctx.item.source_name == "LSP" then
                                local color_item =
                                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                if color_item and color_item.abbr_hl_group then
                                    highlight = color_item.abbr_hl_group
                                end
                            end
                            return highlight
                        end,
                    },
                },
            },

            signature = {
                enabled = true,
            },

            keymap = {
                preset = "enter",
                ["<C-s>"] = {
                    function(cmp)
                        cmp.show({ providers = { "snippets" } })
                    end,
                },
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<Tab>"] = {
                    "snippet_forward",
                    "fallback",
                },
                ["<C-k>"] = { "select_prev" },
                ["<C-j>"] = { "select_next" },
                ["<C-b>"] = { "scroll_documentation_up" },
                ["<C-f>"] = { "scroll_documentation_down" },
                ["<C-h>"] = { "show_signature", "hide_signature", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            cmdline = {
                completion = {
                    menu = { auto_show = true },
                    list = {
                        selection = { preselect = false, auto_insert = false },
                    },
                },
                keymap = {
                    preset = "inherit",
                },
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },
        },
        opts_extend = { "sources.default" },
    },
}
