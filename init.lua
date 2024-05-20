--------------------------------------------------
-- This config uses "Lazy" as the package manager.
--------------------------------------------------

-- Loads Lazy (package manager) if not already present.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Include our vim options
require("vim-options")

-- Runs Lazy. Takes export from lua/plugins.lua
require("lazy").setup("plugins")


