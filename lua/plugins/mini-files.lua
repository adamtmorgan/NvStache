return {
	"echasnovski/mini.files",
	version = "*",
	config = function()
		require("mini.files").setup({
			windows = {
				preview = true,
				width_preview = 120,
			},
		})

		local function open_cwd()
			MiniFiles.open(nil, false)
		end

		local function open_current_buffer()
			MiniFiles.open(vim.api.nvim_buf_get_name(0))
		end

		vim.keymap.set("n", "<leader>o", open_cwd, { silent = true })
		vim.keymap.set("n", "<leader>e", open_current_buffer, { silent = true })
	end,
}
