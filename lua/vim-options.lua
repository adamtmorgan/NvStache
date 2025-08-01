------------------------------------------
-- Misc default settings
------------------------------------------
vim.cmd("set expandtab")
vim.cmd("set splitright")
vim.cmd("set nowrap")

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 50

------------------------------------------
-- Visual behavior
------------------------------------------

-- Makes it so status bar is shared across panes
vim.opt.laststatus = 3

-- Makes hover windows rounded
vim.o.winborder = "rounded"

-- Renders inline errors and warnings on separate lines
vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines = true
})

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
vim.keymap.set("n", "<leader>/", ":noh<CR>", { silent = true })

-- Switch between panes and tabs quickly
vim.keymap.set("n", "<C-t>n", ":tabnew<CR>", { noremap = true, silent = true }) -- overrites ctag (idc since we use lsp)
vim.keymap.set("n", "<C-t>c", ":tabclose<CR>", { noremap = true, silent = true }) -- overrites ctag (idc since we use lsp)
vim.keymap.set("n", "<C-t>l", ":+tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-t>h", ":-tabnext<CR>", { noremap = true, silent = true })

-- Switch between buffers quickly
vim.keymap.set("n", "<leader>l", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true })

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
-- replacing it completely.
vim.cmd("autocmd CmdlineEnter * :set cmdheight=1")
vim.opt.cmdheight = 0
vim.cmd("autocmd CmdlineLeave * :set cmdheight=0")

------------------------------------------
-- LSP Wiring
------------------------------------------

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

------------------------------------------
-- Neovide-specific settigns
------------------------------------------
if vim.g.neovide then
    -- Cursorline has bugs in Neovide
    vim.opt.cursorline = false

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

    -- Cursor and animation
    vim.g.neovide_cursor_animation_length = 0.08
    vim.g.neovide_cursor_trail_size = 0.6
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.15

    -- Copy/paste in neovide:
    vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
    vim.keymap.set("v", "<D-c>", '"+y') -- Copy
    vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
    vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
    vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
    vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end
