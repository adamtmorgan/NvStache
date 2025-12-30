vim.lsp.enable({
    "bashls",
    "bufls",
    "clangd",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "glsl_analyzer",
    "graphql",
    "html",
    "intelephense",
    "jsonls",
    "lua_ls",
    "ty",
    "kotlin_lsp",
    "rnix",
    "sqlls",
    "taplo",
    "terraformls",
    "vtsls",
    "eslint",
    "vue_ls",
    "wgsl_analyzer",
    "yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            if client:supports_method("textDocument/inlayHint") and vim.g.auto_inlay_hint then
                vim.lsp.inlay_hint.enable()
            end
            -- -@see doc :h vim.lsp.document_color
            if client:supports_method("textDocument/documentColor") then
                if vim.lsp.document_color then
                    vim.lsp.document_color.enable(true, args.buf, {
                        style = "virtual",
                    })
                end
            end
        end

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
        vim.keymap.set("n", "gh", vim.lsp.buf.hover, { noremap = true })
        vim.keymap.set("n", "ge", vim.diagnostic.open_float, { noremap = true })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
    end,
})
