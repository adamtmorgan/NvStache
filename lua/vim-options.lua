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

-- Switch between buffers quickly
vim.keymap.set("n", "<leader>l", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { noremap = true, silent = true })

-- Popup buffer command quickly
vim.keymap.set("n", "<leader>b", ":b ", { noremap = true, silent = true })

-- Clears all buffers except for the currently open one
vim.keymap.set("n", "<leader>!", ":Clean<CR>", { noremap = true, silent = true })
vim.api.nvim_create_user_command("Clean", function()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(buffers) do
		if buf ~= current_buf then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, {})

------------------------------------------
-- Dynamic behavior (auto commands)
------------------------------------------
vim.cmd("autocmd InsertEnter * :set norelativenumber")
vim.cmd("autocmd InsertLeave * :set relativenumber")
