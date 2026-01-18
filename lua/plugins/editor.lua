-- ----------------------------------------------
-- Plugins that enhance editor functionality.
-- ----------------------------------------------

return {
    -- Allows typescript context support for commenting.
    -- This makes commenting in TSX blocks much more convenient.
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
            -- add any options here
        },
        config = function()
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })

            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function(filetype, option)
                return option == "commentstring"
                        and require("ts_context_commentstring.internal").calculate_commentstring()
                    or vim.filetype.get_option(filetype, option)
            end
        end,
    },

    -- Documentation generation based on function signatures.
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({})
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<Leader>g", ":lua require('neogen').generate()<CR>", opts)
        end,
    },

    -- Enhances crate composing in cargo.toml files
    {
        "saecki/crates.nvim",
        tag = "stable",
        config = function()
            require("crates").setup({
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            })
        end,
    },

    -- Auto adds closing brackets, braces, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },

    -- For editing enclosing chars or blocks
    -- 's' is used as an object reference. Just as if you'd say `ciw` to
    -- change inside word, you'd say `cs{[` to change a surrounding `{` to a `[`
    {
        -- "tpope/vim-surround",
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },

    -- Used to quickly align text vertically across rows.
    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set("x", "ga", ":EasyAlign ", { silent = true })
        end,
    },

    -- For auto-detecting and changing `shiftwidth` and `expandtab`
    -- settings based on the current file's pattern.
    { "tpope/vim-sleuth" },

    -- Adds auto closing and renaming tags
    {
        "windwp/nvim-ts-autotag",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-ts-autotag").setup({
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = false, -- Auto close on trailing </
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                --per_filetype = {
                --	["html"] = {
                --		enable_close = false,
                --	},
                --},
            })
        end,
    },

    -- Multicursor support
    -- Make sure to disable Ctl<up> and Ctl<down> bindings in MacOS
    -- if you haven't already. Using default bindings.
    {
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
    },
}
