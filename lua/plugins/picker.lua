return {
	"folke/snacks.nvim",
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			prompt = "  ",
			ui_select = true,
			win = {
				input = {
					keys = {
						["<C-;>"] = { "close", mode = { "n" } },
						["<C-c>"] = { "close", mode = { "i", "n" } },
					},
				},
				list = {
					keys = {
						["<C-;>"] = { "close", mode = { "n" } },
						["<C-c>"] = { "close", mode = { "i", "n" } },
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>fp",
			function()
				Snacks.picker()
			end,
			desc = "Find Pickers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>o",
			function()
				Snacks.picker.explorer({
					layout = { preset = "default", preview = true },
					follow_file = true,
					auto_close = true,
					win = {
						input = {
							keys = {
								["<C-;>"] = { "close", mode = { "n" } },
								["<C-c>"] = { "close", mode = { "i", "n" } },
							},
						},
						list = {
							keys = {
								["<Enter>"] = "confirm",
								["<C-;>"] = { "close", mode = { "n" } },
								["<C-c>"] = { "close", mode = { "i", "n" } },
							},
						},
					},
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Buffers",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep",
		},
		{
			"<leader>fG",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Live Grep",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto Type Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>ca",
			function()
				Snacks.picker.actions()
			end,
			desc = "LSP Symbols",
		},
	},
}
