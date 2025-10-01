return {
    "rmagatti/auto-session",
    keys = {
        { "<leader>fs", "<cmd>AutoSession search<CR>", desc = "Session search" },
        { "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "Session restore" },
        { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Session save" },
    },
    opts = {
        log_level = "error",
        close_unsupported_windows = true,
        auto_session_create_enabled = false,
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = true, -- Disable automatic saving for new sessions
        auto_restore_enabled = true,
        auto_session_suppress_dirs = nil,
        bypass_session_save_file_types = { "netrw", "oil" },
        pre_save_cmds = { -- Ensures floating windows are closed prior to save
            function()
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    local config = vim.api.nvim_win_get_config(win)
                    if config.relative ~= "" then
                        vim.api.nvim_win_close(win, false)
                    end
                end
            end,
            -- Closes file browsers before saving
            -- function()
            -- 	-- Get a list of all buffers
            -- 	local buffers = vim.api.nvim_list_bufs()
            --
            -- 	-- Iterate through each buffer
            -- 	for _, buf in ipairs(buffers) do
            -- 		-- Get the file type of the buffer
            -- 		local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
            --
            -- 		-- Check if the file type is one of the common file explorers
            -- 		if filetype == "netrw" or filetype == "oil" then
            -- 			-- Close the buffer
            -- 			vim.api.nvim_buf_delete(buf, { force = true })
            -- 		end
            -- 	end
            -- end,
        },
    },
}
