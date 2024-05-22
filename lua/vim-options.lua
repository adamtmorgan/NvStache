-- Personal vim settings
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

-- Ignore certain dirs in search

-- For node projects
vim.opt.wildignore:append({ "*/node_modules/*" })

--vim.cmd("set number=true")

-- Set leader key
vim.g.mapleader = " "

-- General key maps
vim.keymap.set("n", "<leader>/", ":noh<CR>", {})

-- Dynamic behavior
vim.cmd("autocmd InsertEnter * :set norelativenumber")
vim.cmd("autocmd InsertLeave * :set relativenumber")
