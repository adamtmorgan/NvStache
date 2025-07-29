return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local float_options = {
                max_width = 120,
                max_height = 40,
                border = "rounded",
            }

            local oil = require("oil")
            oil.setup({
                default_file_explorer = true,
                columns = {
                    -- "size",
                    "icon",
                },
                float = float_options,
                -- Custom key bindings
                use_default_keymaps = false,
                keymaps = {
                    ["<CR>"] = "actions.select", -- Enter key to open file or directory
                    ["<C-s>"] = {
                        "actions.select",
                        opts = { vertical = true },
                        desc = "Open the entry in a vertical split",
                    },
                    ["-"] = "actions.parent", -- '-' to go up one directory level
                    ["_"] = "actions.open_cwd", -- opens current working dir
                    ["<C-c>"] = { callback = "actions.close", mode = "n" },
                    ["<leader>o"] = { callback = "actions.close", mode = "n" },
                    ["<leader>e"] = { callback = "actions.close", mode = "n" },
                    ["<C-x>"] = { callback = oil.discard_all_changes, mode = "n" },
                    ["<C-r>"] = "actions.refresh", -- Ctrl+r to refresh the directory
                    ["<leader>O"] = "actions.open_external",
                },
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = true,
                    -- This function defines what is considered a "hidden" file
                    is_hidden_file = function(name, bufnr)
                        return vim.startswith(name, ".")
                    end,
                    -- This function defines what will never be shown, even when `show_hidden` is set
                    is_always_hidden = function(name, bufnr)
                        return false
                    end,
                    -- Sort file names in a more intuitive order for humans. Is less performant,
                    -- so you may want to set to false if you work with large directories.
                    natural_order = true,
                    sort = {
                        -- sort order can be "asc" or "desc"
                        -- see :help oil-columns to see which columns are sortable
                        { "type", "asc" },
                        { "name", "asc" },
                    },
                },
            })

            -- Set keymaps
            vim.keymap.set("n", "<leader>e", ":Oil ./ --float<CR>", { silent = true })
            vim.keymap.set("n", "<leader>o", ":Oil --float<CR>", { silent = true })
        end,
    },
}
