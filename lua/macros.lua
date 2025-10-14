local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

--------------------------------------------------
-- JavaScript/Typescript Macros
--------------------------------------------------

vim.api.nvim_create_augroup("JsMacros", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    group = "JsMacros",
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
    callback = function()
        -- Creates a console.log line with selected text as the log value.
        vim.fn.setreg("l", 'yoconsole.log("' .. esc .. 'pa", ' .. esc .. "pa);" .. esc)
    end,
})
vim.api.nvim_create_autocmd("BufLeave", {
    group = "JsMacros",
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
    callback = function()
        vim.fn.setreg("l", "")
    end,
})
