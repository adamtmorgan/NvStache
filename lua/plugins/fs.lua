return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local oil = require("oil")
            local util = require("oil.util")

            oil.setup({
                default_file_explorer = true,
                columns = {
                    -- "size",
                    "icon",
                },
                float = {
                    max_width = 190,
                    max_height = 50,
                    border = "rounded",
                    win_options = {
                        number = true,
                    },
                },
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
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = { callback = "actions.close", mode = "n" },
                    ["<leader>o"] = { callback = "actions.close", mode = "n" },
                    ["<leader>e"] = { callback = "actions.close", mode = "n" },
                    ["<C-x>"] = { callback = oil.discard_all_changes, mode = "n" },
                    ["<C-r>"] = "actions.refresh", -- Ctrl+r to refresh the directory
                    ["<leader>O"] = "actions.open_external",
                },
                preview_win = {
                    -- Whether the preview window is automatically updated when the cursor is moved
                    update_on_cursor_moved = true,
                    -- How to open the preview window "load"|"scratch"|"fast_scratch"
                    preview_method = "fast_scratch",
                    -- A function that returns true to disable preview on a file e.g. to avoid lag
                    disable_preview = function(filename)
                        return false
                    end,
                    -- Window-local options to use for preview window buffers
                    win_options = {
                        relativenumber = true,
                    },
                },
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = true,
                    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                    preview_split = "right",
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

            function OpenOilCustom(dir)
                local oil_local = require("oil")
                local util_local = require("oil.util")
                oil_local.open_float(dir)
                util_local.run_after_load(0, function()
                    oil_local.open_preview()
                end)
            end

            -- Set keymaps
            vim.keymap.set("n", "<leader>e", function()
                OpenOilCustom("./")
            end, { silent = true })
            vim.keymap.set("n", "<leader>O", function()
                OpenOilCustom()
            end, { silent = true })
        end,
    },
}
