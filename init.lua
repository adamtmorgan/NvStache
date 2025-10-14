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

-- Enabled LSPs
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
    "pyright",
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

-- Runs Lazy. Takes export from lua/plugins.lua
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    ui = {
        border = "rounded"
    }
})

-- Adds connections for dadbod
-- attempts to pull them from root. if not found, set to empty.
local status, connection_strings = pcall(require, "db_connections")
if status then
    vim.g.dbs = connection_strings
else
    vim.g.dbs = {}
end
