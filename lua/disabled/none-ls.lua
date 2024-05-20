-- none-ls similar to null-ls.
-- streamlines formatting tools to work as a
-- lsp rather than having to worry about installing
-- each one separately.

return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        --"nvimtools/none-ls-extras.nvim",
		--"gbprod/none-ls-shellcheck.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                --require("none-ls.diagnostics.eslint_d"),
				--require("none-ls.formatting.eslint_d"),
				--require("none-ls.code_actions.eslint_d"),
				--require("none-ls-shellcheck.diagnostics"),
				--require("none-ls-shellcheck.code_actions"),
            },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
