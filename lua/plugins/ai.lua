return {
	-- Required to use copilot as provider
	{
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		config = function()
			---@diagnostic disable-next-line: redundant-parameter
			require("copilot").setup({
				suggestion = { enabled = false }, -- Disable if using avante for suggestions
				panel = { enabled = false }, -- Disable panel if not needed
				filetypes = {
					["*"] = false, -- Enable Copilot for all filetypes, or specify as needed
				},
			})
		end,
	},
	--------------------------------------------------
	-- Code Companion
	--------------------------------------------------
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	opts = {
	-- 		adapters = {
	-- 			llama3 = function()
	-- 				return require("codecompanion.adapters").extend("copilot", {
	-- 					name = "copilot", -- Give this adapter a different name to differentiate it from the default ollama adapter
	-- 					schema = {
	-- 						model = {
	-- 							default = "gemini-2.5-pro",
	-- 						},
	-- 						-- num_ctx = {
	-- 						-- 	default = 16384,
	-- 						-- },
	-- 					},
	-- 				})
	-- 			end,
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"zbirenbaum/copilot.lua",
	-- 	},
	-- 	config = function()
	-- 		require("codecompanion").setup()
	--
	-- 		vim.keymap.set("n", "<leader>a", ":CodeCompanionActions<CR>", { silent = true })
	-- 	end,
	-- },
	--------------------------------------------------
	-- Avante
	--------------------------------------------------
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			-- for example
			-- "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "copilot",
			copilot = {
				endpoint = "https://api.githubcopilot.com", -- Copilot API endpoint
				model = "claude-3.7-sonnet", -- Specify the desired model
				-- Options:
				-- gpt-4o
				-- gpt-4.1
				-- claude-3.5-sonnet
				-- claude-3.7-sonnet
				-- gemini-2.0-flash
				-- gemini-2.5-pro
				-- o1
				-- o2
				-- o3
				-- o3-mini
				-- o4-mini
				timeout = 30000, -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 4096, -- Maximum tokens for response
			},
			-- openai = {
			-- 	endpoint = "https://api.openai.com/v1",
			-- 	model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
			-- 	timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			-- 	temperature = 0,
			-- 	max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
			-- 	--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
			-- },
			-- claude = {
			-- 	endpoint = "https://api.anthropic.com",
			-- 	model = "claude-3-5-sonnet-20241022",
			-- 	temperature = 0,
			-- 	max_tokens = 4096,
			-- },
			selector = {
				provider = "snacks",
			},
			hints = { enabled = true },
			windows = {
				width = 45,
				wrap = true,
				edit = {
					border = "rounded",
				},
				input = {
					prefix = " ",
					height = 8, -- Height of the input window in vertical layout
				},
				ask = {
					floating = false,
					border = "rounded",
				},
			},
			mappings = {
				sidebar = {
					close = { "<C-c>" },
					close_from_input = { normal = "<C-c>", insert = "<C-c>" },
				},
			},
			-- system_prompt = [[
			-- 	Important user preferences:
			--
			-- 	- Never add or remove code comments unless I ask for it. Instead, make
			-- 	  your code self-explanatory using good variable names and semantics.
			-- 	- If the language allows it, make full use of static typing and
			-- 	  inference.
			-- 	- If you need to provide a summary of what we've done, make it
			-- 	  extremely concise regardless of what you've been asked to do before.
			-- 	- Never spend any words to say why your solution is good at the end of
			-- 	  your response.
			-- ]],
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			-- "stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		config = function(_, ops)
			require("avante").setup(ops)
			-- fix the border highlights
			vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { link = "WinSeparator" })
			vim.api.nvim_set_hl(0, "AvanteSidebarWinHorizontalSeparator", { link = "WinSeparator" })
			-- vim.api.nvim_set_hl(0, "AvantePromptInput", { link = "WinSeparator" })
			-- vim.api.nvim_set_hl(0, "AvantePromptInputBorder", { link = "FloatBorder" })
		end,
	},
}
