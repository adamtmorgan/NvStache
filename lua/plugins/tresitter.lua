return {
    {
        "nvim-treesitter/nvim-treesitter",
        --dependencies = { "windwp/nvim-ts-autotag" },
        build = ":TSUpdate",
        config = function()
            local treeSitterConfig = require("nvim-treesitter.configs")
            ---@diagnostic disable-next-line: missing-fields -- Works without "required" fields
            treeSitterConfig.setup({
                ensure_installed = {
                    -- Programming/styling languages
                    "jsdoc",
                    "javascript",
                    "typescript",
                    "tsx",
                    "vue",
                    "svelte",
                    "html",
                    "css",
                    "scss",
                    "rust",
                    "lua",
                    "wgsl",
                    "glsl",
                    "qmljs",
                    "qmldir",
                    "php",
                    "python",
                    "kotlin",
                    "java",
                    "arduino",

                    -- Data
                    "sql",
                    "graphql",
                    "json",
                    "proto",
                    "csv",
                    "tsv",
                    "psv",

                    -- Config languages
                    "toml",
                    "yaml",
                    "ron",
                    "terraform",
                    "dockerfile",
                    "gitignore",
                    "nginx",

                    -- System scripting
                    "bash",
                    "nix",

                    -- Misc
                    "markdown",
                    "regex",
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    -- Adds sticky context to the top of the page.
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = true, -- Enable multiwindow support.
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                -- separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })

            vim.api.nvim_set_hl(0, "TreesitterContext", { background = "none" })
            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "#3F3B4F" })
        end,
    },
}
