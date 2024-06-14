return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			log_level = "error",
			auto_session_enable_last_session = false,
			auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
			auto_session_enabled = true,
			auto_save_enabled = true, -- Disable automatic saving for new sessions
			auto_restore_enabled = true,
			auto_session_suppress_dirs = nil,
			pre_save_cmds = { -- Ensures floating windows are closed prior to save
				function()
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						local config = vim.api.nvim_win_get_config(win)
						if config.relative ~= "" then
							vim.api.nvim_win_close(win, false)
						end
					end
				end,
			},
		})

		-- Popup telescope browser for sessions
		vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, {
			noremap = true,
		})

		vim.keymap.set("n", "<C-s>s", ":SessionSave<CR>", {
			noremap = true,
			silent = false,
		})
		vim.keymap.set("n", "<C-s>r", ":SessionRestore<CR>", {
			noremap = true,
			silent = false,
		})
	end,
}
