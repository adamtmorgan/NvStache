return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommendedzy
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
    ops = {
        filesystem = {
            filtered_items = {
                visible = true,
                --hide_dotfiles = false,
                --hide_gitignored = false,
            },
        },
    },
	config = function()
		require("neo-tree").setup({
			default_component_configs = {
				indent = {
					with_markers = true,
				},
			},
		})
		vim.keymap.set("n", "<C-b>", ":Neotree toggle<CR>", {})
	end,
}
