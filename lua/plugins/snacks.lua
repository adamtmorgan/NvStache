return {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            prompt = "  ",
            ui_select = true,
            win = {
                input = {
                    keys = {
                        ["<C-;>"] = { "close", mode = { "n" } },
                        ["<C-c>"] = { "close", mode = { "i", "n" } },
                    },
                },
                list = {
                    keys = {
                        ["<C-;>"] = { "close", mode = { "n" } },
                        ["<C-c>"] = { "close", mode = { "i", "n" } },
                    },
                },
            },
        },
        input = { enabled = true },

        -- Tested below and I prefer indent-blankline, as it's
        -- more robust at time of writing.
        indent = {
            priority = 100,
            indent = {
                enabled = true,
                char = "▏",
                hl = "FloatBorder",
            },
            scope = {
                enabled = true,
                underline = false,
                char = "▏",
                only_current = true,
                -- hl = "@tag.delimiter", -- assuming kanagawa
                hl = "@variable.parameter", -- assuming kanagawa
            },
            animate = {
                enabled = false,
            },
        },
        scope = { enabled = true },
    },
    keys = {
        {
            "<leader>fp",
            function()
                Snacks.picker()
            end,
            desc = "Find Pickers",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files({
                    hidden = true,
                })
            end,
            desc = "Find Files",
        },
        {
            "<leader>O",
            function()
                Snacks.picker.explorer({
                    layout = { preset = "default", preview = true },
                    follow_file = true,
                    auto_close = true,
                    win = {
                        input = {
                            keys = {
                                ["<C-;>"] = { "close", mode = { "n" } },
                                ["<C-c>"] = { "close", mode = { "i", "n" } },
                            },
                        },
                        list = {
                            keys = {
                                ["<Enter>"] = "confirm",
                                ["<C-;>"] = { "close", mode = { "n" } },
                                ["<C-c>"] = { "close", mode = { "i", "n" } },
                            },
                        },
                    },
                })
            end,
            desc = "Find Files",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Find Buffers",
        },
        {
            "<leader>/",
            function()
                Snacks.picker.grep({
                    hidden = true,
                })
            end,
            desc = "Live Grep",
        },
        {
            "<leader>fw",
            function()
                Snacks.picker.grep_word({
                    hidden = true,
                })
            end,
            desc = "Live Grep",
        },
        -- https://github.com/folke/snacks.nvim/discussions/1069
        -- Allows searching of a dir to then grep inside of
        {
            "<leader>f/",
            function()
                Snacks.picker({
                    finder = "proc",
                    cmd = "fd",
                    args = { "--type", "d", "--exclude", ".git" },
                    title = "Select directory to grep",
                    layout = {
                        preset = "select",
                    },
                    actions = {
                        confirm = function(picker, item)
                            picker:close()
                            vim.schedule(function()
                                Snacks.picker.grep({
                                    cwd = item.file,
                                })
                            end)
                        end,
                    },
                    transform = function(item)
                        item.file = item.text
                        item.dir = true
                    end,
                })
            end,
            desc = "Search in dir",
        },
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "gi",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "gt",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto Type Definition",
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>ca",
            function()
                Snacks.picker.actions()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>fj",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Find Jumps",
        },
    },
}
