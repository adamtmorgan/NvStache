------------------------------------------
-- Personal vim settings
------------------------------------------
vim.cmd("set expandtab")

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.scrolloff = 50

------------------------------------------
-- Ignore certain dirs in search
------------------------------------------

-- For node projects
vim.opt.wildignore:append({ "*/node_modules/*" })

------------------------------------------
-- General key maps
------------------------------------------

-- Set leader key
vim.g.mapleader = " "

-- Clear search
vim.keymap.set("n", "<leader>/", ":noh<CR>", {})

-- Switch between panes and tabs quickly
vim.keymap.set("n", "<C-t>n", ":tabnew<CR>", { noremap = true, silent = true }) -- overrites ctag (idc since we use lsp)
vim.keymap.set("n", "<C-t>c", ":tabclose<CR>", { noremap = true, silent = true }) -- overrites ctag (idc since we use lsp)
vim.keymap.set("n", "<C-t>l", ":+tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-t>h", ":-tabnext<CR>", { noremap = true, silent = true })

------------------------------------------
-- Dynamic behavior (auto commands)
------------------------------------------
vim.cmd("autocmd InsertEnter * :set norelativenumber")
vim.cmd("autocmd InsertLeave * :set relativenumber")
