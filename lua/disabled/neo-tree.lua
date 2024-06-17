return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommendedzy
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
			},
			default_component_configs = {
				indent = {
					with_markers = true,
					expander_collapsed = "",
					expander_expanded = "",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "󰜌",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
			},
			filesystem = {
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						".DS_Store",
					},
				},
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
						-- ["D"] = "fuzzy_sorter_directory",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["og"] = { "order_by_git_status", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
						-- ['<key>'] = function(state) ... end,
					},
					fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
						["<down>"] = "move_cursor_down",
						["<C-j>"] = "move_cursor_down",
						["<up>"] = "move_cursor_up",
						["<C-k>"] = "move_cursor_up",
						-- ['<key>'] = function(state, scroll_padding) ... end,
					},
				},
			},
			window = {
				position = "float",
			},
		})
		vim.keymap.set("n", "<C-b>", ":Neotree toggle<CR>", {})
	end,
}
