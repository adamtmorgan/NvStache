return {
	"akinsho/toggleterm.nvim",
	version = "*",
	ops = {
		shade_terminals = false,
		persist_size = false,
	},
	config = function()
		local Terminal = require("toggleterm.terminal").Terminal
		vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

		-- --------------------------------------------------
		-- Lazygit
		-- --------------------------------------------------
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "rounded",
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
				title_pos = "center",
			},
			highlights = {
				NormalFloat = { guifg = "#DDD8BB" },
			},
			shade_terminals = false,
			shading_factor = 0,
			shading_ratio = 0,
			persist_size = false,
			close_on_exit = true,
		})
		function Lazygit_toggle()
			lazygit:toggle()
		end
		vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })
	end,
}
