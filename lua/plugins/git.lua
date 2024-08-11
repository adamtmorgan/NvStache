-- Shows inline git blame
return {
	-- Allows execution and previewing of git commands from vim
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { silent = true })
		end,
	},
	-- Git features in the editor (showing lines changed, for example)
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
