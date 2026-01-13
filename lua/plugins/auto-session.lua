return {
    "rmagatti/auto-session",
    lazy = false, -- required to auto-restore
    keys = {
        { "<C-s>f", "<cmd>AutoSession search<CR>", desc = "Session search" },
        { "<C-s>r", "<cmd>AutoSession restore<CR>", desc = "Session restore" },
        { "<C-s>s", "<cmd>AutoSession save<CR>", desc = "Session save" },
    },
    opts = {
        enabled = true,
        auto_save = true,
        auto_create = true,
        auto_restore = true,
        root_dir = vim.fn.stdpath("data") .. "/sessions/",
        git_use_branch_name = true,
        git_auto_restore_on_branch_change = true,
        purge_after_minutes = 43200, -- 30 days
        session_lens = {
            mappings = {
                delete_session = { "i", "<C-x>" },
                alternate_session = { "i", "<C-s>" },
                copy_session = { "i", "<C-y>" },
            },
        },
    },
}
