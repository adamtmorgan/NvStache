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
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	-- {
	-- 	"akinsho/toggleterm.nvim",
	-- 	version = "*",
	-- 	ops = {
	-- 		shade_terminals = false,
	-- 		persist_size = false,
	-- 	},
	-- 	config = function()
	-- 		local Terminal = require("toggleterm.terminal").Terminal
	-- 		local lazygit = Terminal:new({
	-- 			cmd = "lazygit",
	-- 			hidden = true,
	-- 			direction = "float",
	-- 			float_opts = {
	-- 				border = "rounded",
	-- 			},
	-- 			border = "none",
	-- 			shade_terminals = false,
	-- 			shading_factor = 0,
	-- 			shading_ratio = 0,
	-- 			persist_size = false,
	-- 		})
	--
	-- 		function _lazygit_toggle()
	-- 			lazygit:toggle()
	-- 		end
	--
	-- 		vim.api.nvim_set_keymap(
	-- 			"n",
	-- 			"<leader>g",
	-- 			"<cmd>lua _lazygit_toggle()<CR>",
	-- 			{ noremap = true, silent = true }
	-- 		)
	-- 	end,
	-- },
}
