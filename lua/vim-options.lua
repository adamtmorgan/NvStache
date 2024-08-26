------------------------------------------
-- Misc default settings
------------------------------------------
vim.cmd("set expandtab")
vim.cmd("set splitright")

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
-- Visual behavior
------------------------------------------

-- Makes it so status bar is shared across panes
vim.opt.laststatus = 3

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

-- Allow clipboard copy/paste
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

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

-- Neovide-specific config
if vim.g.neovide then
	-- Font
	vim.o.guifont = "JetBrainsMono Nerd Font:h12"
	vim.opt.linespace = 0

	-- Window styling
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 5
	vim.g.neovide_padding_left = 5

	vim.g.neovide_show_border = true
	vim.g.neovide_hide_titlebar = true

	vim.g.neovide_scroll_animation_length = 0.2

	vim.g.neovide_floating_transparency = 1
	vim.g.neovide_window_floating_opacity = 1

	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
	end
	vim.g.neovide_transparency = 1
	vim.g.transparency = 0.9
	vim.g.neovide_background_color = "#1c2129" .. alpha()
	vim.g.neovide_window_blurred = true

	vim.g.neovide_floating_shadow = false
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5

	-- Behavior
	vim.g.neovide_hide_mouse_when_typing = 1
end
