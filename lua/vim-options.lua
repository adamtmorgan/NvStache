------------------------------------------
-- Misc default settings
------------------------------------------
vim.cmd("set expandtab")
vim.cmd("set splitright")
vim.cmd("set nowrap")

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 50
vim.opt.showtabline = 0

------------------------------------------
-- Visual behavior
------------------------------------------

-- Conditionally show cursorline per buffer
vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("CursorLine", { clear = true }),
    callback = function(event)
        local buftype_exclusions = {
            "nofile",
            "quickfix",
            "terminal",
            "prompt",
            "help",
        }
        local filetype_exclusions = {
            "dashboard",
            "startify",
            "qf",
            "help",
            "man",
            "neo-tree",
            "nvim-tree",
            "nerdtree",
            "telescope",
            "fzf",
            "aerial",
        }
        if
            not vim.tbl_contains(buftype_exclusions, vim.bo.buftype)
            and not vim.tbl_contains(filetype_exclusions, vim.bo.filetype)
        then
            vim.wo.cursorline = (event.event == "WinEnter" or event.event == "BufEnter")
        else
            vim.wo.cursorline = false
        end
    end,
})

-- Makes it so status bar is shared across panes
vim.opt.laststatus = 3
-- vim.opt.winbar = "%f"

-- Makes hover windows rounded
vim.o.winborder = "rounded"

-- Renders inline errors and warnings on separate lines
vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines = true
})

-- Set session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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

-- Rebind escape for simpler
vim.keymap.set("n", "<C-;>", "<esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-;>", "<esc>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-;>", "<esc>", { noremap = true, silent = true })
vim.keymap.set("c", "<C-;>", "<C-c>", { noremap = true, silent = true })

-- Allow clipboard copy/paste
vim.keymap.set("n", "<S-j>", ":move .+1<CR>", { silent = true })
vim.keymap.set("n", "<S-k>", ":move .-2<CR>", { silent = true })
vim.keymap.set("v", "<S-j>", ":move '>+1<CR> gv", { silent = true })
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Mapping for shifting lines up or down
vim.keymap.set("v", "<S-k>", ":move '<-2<CR> gv", { silent = true })

-- Clear search
vim.keymap.set("n", "<C-/>", ":noh<CR>", { silent = true })

-- Switch between panes and tabs quickly
vim.keymap.set("n", "<C-t>n", ":tabnew<CR>", { noremap = true, silent = true }) -- overrites ctag (idc since we use lsp)
vim.keymap.set("n", "<C-t>c", ":tabclose<CR>", { noremap = true, silent = true }) -- overrites ctag (idc since we use lsp)
vim.keymap.set("n", "<C-t>l", ":+tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-t>h", ":-tabnext<CR>", { noremap = true, silent = true })

-- Larger resize interval
vim.keymap.set("n", "<C-w><", ":vertical resize +12<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>>", ":vertical resize -12<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>+", ":resize 15<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>-", ":res=ze -15<CR>", { noremap = true, silent = true })

-- Switch between buffers quickly
vim.keymap.set("n", "<leader>l", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", ":bd<CR>", { noremap = true, silent = true })

-- Toggle diagnostics text
vim.api.nvim_create_user_command("ToggleDiagnosticsLines", function()
    if vim.diagnostic.config().virtual_lines then
        vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
    else
        vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    end
end, {})
vim.keymap.set("n", "<leader>tD", ":ToggleDiagnosticsLines<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("ToggleDiagnosticsText", function()
    if vim.diagnostic.config().virtual_text then
        vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
    else
        vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
    end
end, {})
vim.keymap.set("n", "<leader>td", ":ToggleDiagnosticsText<CR>", { noremap = true, silent = true })

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

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

------------------------------------------
-- Dynamic behavior (auto commands)
------------------------------------------
vim.cmd("autocmd InsertEnter * :set norelativenumber")
vim.cmd("autocmd InsertLeave * :set relativenumber")

-- Show command line below status bar rather than
-- replacing it completely. (disabled since using noice)
vim.opt.cmdheight = 0
-- vim.cmd("autocmd CmdlineEnter * :set cmdheight=1")
-- vim.cmd("autocmd CmdlineLeave * :set cmdheight=0")

-- Use ripgrep instead of grep as default
vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
vim.opt.grepformat = "%f:%l:%c:%m"
