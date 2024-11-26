return {
	-- FZF Native. Fuzzy-finds results in telescope. Requires "gcc or clang as well as make".
	-- This actually builds the dependency on device. Might not be compatible with all systems.
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	-- tiny-code-actions is a substitute for code actions window that shows
	-- a preview of the changes before committing.
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		config = function()
			require("tiny-code-action").setup()
		end,
	},
	-- Main telescope plugin
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		config = function()
			local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
			local telescopeBuiltin = require("telescope.builtin")
			local telescope = require("telescope")

			vim.keymap.set("n", "<leader>ff", telescopeBuiltin.find_files, {})
			vim.keymap.set("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, {})
			vim.keymap.set("v", "<leader>fg", live_grep_args_shortcuts.grep_visual_selection, {})
			vim.keymap.set("n", "<leader>fc", live_grep_args_shortcuts.grep_word_under_cursor, {})
			vim.keymap.set("n", "<leader>fb", telescopeBuiltin.buffers, {})
			vim.keymap.set("n", "<leader>fh", telescopeBuiltin.help_tags, {})
		end,
	},
	-- plugin for telescope that makes select UI look nicer.
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local open_with_trouble = require("trouble.sources.telescope").open
			-- local add_to_trouble = require("trouble.sources.telescope").add
			local actions = require("telescope.actions")

			local telescope = require("telescope")

			telescope.setup({
				-- Override some mappings
				defaults = {
					max_results = 50,
					-- Use ripgrep (installed separately) as the live-grep source.
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					-- Cache results to make things snappier
					cache_picker = {
						num_pickers = 10,
					},
					layout_config = {
						horizontal = {
							width = 0.85,
							height = 0.85,
							preview_width = 0.45,
						},
						vertical = {
							width = 0.85,
							height = 0.85,
						},
						center = {
							width = 0.8,
							height = 0.4,
						},
					},
					-- Ignore certain dirs
					file_ignore_patterns = {
						"node_modules",
						".git",
						"dist",
						"build",
						"target",
						"fontawesome*",
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-r>"] = actions.delete_buffer,
							["<C-s>"] = actions.select_vertical,
							["<C-t>"] = open_with_trouble,
						},
						n = {
							["d"] = actions.delete_buffer,
							["<C-s>"] = actions.select_vertical,
							["<C-t>"] = open_with_trouble,
						},
					},
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				},
				pickers = {
					-- code actions using a different plugin, so not including here.
					lsp_definitions = {
						show_line = false,
						layout_strategy = "vertical",
						layout_config = {
							width = 0.7,
							preview_cutoff = 50,
							prompt_position = "top",
						},
					},
					lsp_references = {
						show_line = false,
						layout_strategy = "vertical",
						layout_config = {
							width = 0.7,
							preview_cutoff = 50,
							prompt_position = "top",
						},
					},
					live_grep = {
						show_line = false,
						max_results = 50,
					},
					find_files = {
						max_results = 50,
						find_command = {
							"fd",
							"--type",
							"f",
							"--hidden",
							"--follow",

							-- Project exclusions
							-- "--exclude",
							-- "*/node_modules/*",
							-- "--exclude",
							-- "*/target/*",
							-- "--exclude",
							-- ".git",

							-- Filetype Exclusions
							"--exclude",
							"*.png",
							"--exclude",
							"*.jpg",
							"--exclude",
							"*.jpeg",
							"--exclude",
							"*.gif",
							"--exclude",
							"*.bmp",
							"--exclude",
							"*.tiff",
							"--exclude",
							"*.ico",
							"--exclude",
							"*.mp4",
							"--exclude",
							"*.mp3",
							"--exclude",
							"*.wav",
							"--exclude",
							"*.ogg",
							"--exclude",
							"*.flac",
							"--exclude",
							"*.pdf",
							"--exclude",
							"*.doc",
							"--exclude",
							"*.docx",
							"--exclude",
							"*.ppt",
							"--exclude",
							"*.pptx",
							"--exclude",
							"*.xls",
							"--exclude",
							"*.xlsx",
							"--exclude",
							"*.zip",
							"--exclude",
							"*.tar",
							"--exclude",
							"*.gz",
							"--exclude",
							"*.rar",
							"--exclude",
							"*.7z",
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					persisted = {
						layout_config = {
							width = 0.6,
							height = 0.6,
						},
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			telescope.load_extension("ui-select")

			-- Loads FZF as fuzzy finder
			telescope.load_extension("fzf")

			-- Allows args to be used in telescope live-grep field
			telescope.load_extension("live_grep_args")

			-- Use Noice with telescope
			-- require("telescope").load_extension("noice")
		end,
	},
}
