return {
	"startup-nvim/startup.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		local height = vim.api.nvim_get_option("lines")

		local settings = {
			-- every line should be same width without escaped \
			header = {
				type = "text",
				oldfiles_directory = false,
				align = "center",
				fold_section = false,
				title = "Header",
				margin = 1,
				content = {
					"              ████          ████              ",
					"          ████████████  ████████████          ",
					"        ██████████████████████████████        ",
					"██    ██████████████████████████████████    ██",
					"██████████████████████░░██████████████████████",
					"░░██████████████████▒▒░░▒▒██████████████████░░",
					"      ██████████              ██████████      ",
				},
				-- highlight = "Statement",
				highlight = "",
				default_color = "#DCD7BA",
				oldfiles_amount = 0,
			},
			-- name which will be displayed and command
			body = {
				type = "mapping",
				oldfiles_directory = false,
				align = "center",
				fold_section = false,
				title = "Basic Commands",
				margin = 5,
				content = {
					{ " Grep File", "Telescope find_files", "<leader>ff" },
					{ "󰍉 Grep", "Telescope live_grep", "<leader>fg" },
					{ "󰏇 Browse Files (Oil)", ":Oil ./ --float<CR>", "<leader>o" },
				},
				-- highlight = "String",
				highlight = "",
				default_color = "#DCD7BA",
				oldfiles_amount = 0,
			},
			footer = {
				type = "text",
				oldfiles_directory = false,
				align = "center",
				fold_section = false,
				title = "Footer",
				margin = 5,
				content = { '🍷 "In vino veritas."' },
				highlight = "Number",
				default_color = "",
				oldfiles_amount = 0,
			},

			options = {
				mapping_keys = true,
				cursor_column = 0.5,
				empty_lines_between_mappings = true,
				disable_statuslines = true,
				paddings = { height / 2 - 12, 4, 3, 0 },
			},
			mappings = {
				execute_command = "<CR>",
				open_section = "<TAB>",
				open_help = "?",
			},
			colors = {
				background = "default",
				-- background = "#1f2227",
				folded_section = "#56b6c2",
			},
			parts = { "header", "body", "footer" },
		}
		require("startup").setup(settings)
	end,
}
