return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				--theme = "iceberg_dark",
				--theme = "onedark",
				--theme = "catppuccin",
			},
		})
	end,
}
