--------------------------------------------------------
-- Wires up formatters installed via Mason (or manually)
-- to the current buffer.
--------------------------------------------------------
return {
    "stevearc/conform.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            -- format_on_save = {
            -- 	lsp_fallback = true,
            -- 	async = false,
            -- 	timeout_ms = 500,
            -- },
            default_format_opts = {
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                lua = { "stylua" },
                typescript = { "prettierd" },
                javascript = { "prettierd" },
                typescriptreact = { "prettierd" },
                javascriptreact = { "prettierd" },
                vue = { "prettierd" },
                python = { "ruff_format" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                graphql = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                markdown = { "prettierd" },
                html = { "prettierd" },
                rust = { "rustfmt" },
                c = { "clang-format" },
                glsl = { "clang-format" },
                wgsl = { "wgsl-analyzer", lsp_format = "prefer" }, -- uses lsp
                bash = { "shfmt" },
                toml = { "taplo" },
            },
        })

        -- Set keymap for format
        vim.keymap.set({ "n", "v" }, "<leader>cf", function()
            conform.format()
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
