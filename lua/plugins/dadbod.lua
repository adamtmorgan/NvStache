-- Requires libpq (psql command available) for postgres. `brew install libpq`
return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1

        -- Adds connections for dadbod
        -- attempts to pull them from root. if not found, set to empty.
        local status, connection_strings = pcall(require, "db_connections")
        if status then
            vim.g.dbs = connection_strings
        else
            vim.g.dbs = {}
        end
    end,
}
