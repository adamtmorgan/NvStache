return {
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
}
