-- Shows inline git blame
return {
	-- Shows git signs in editor
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	-- Calls LazyGit inside of Neovim
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
