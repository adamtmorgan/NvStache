local llm_instructions = {
	general_coding = [[
		Important user preferences:

		- Never add or remove code comments unless I ask for it. Instead, make
		  your code self-explanatory using good variable names and semantics.
		- If the language allows it, make full use of static typing and
		  inference.
		- If you need to provide a summary of what we've done, make it
		  extremely concise regardless of what you've been asked to do before.
		- Never spend any words to say why your solution is good at the end of
		  your response.
	  ]],
	-- Taken from Cursor AI workshop
	coding_mdoes = [[
		## META-INSTRUCTION: MODE DECLARATION REQUIREMENT

		**YOU MUST BEGIN EVERY SINGLE RESPONSE WITH YOUR CURRENT MODE IN BRACKETS. NO EXCEPTIONS.** **Format: [MODE: MODE_NAME]** **Failure to declare your mode is a critical violation of protocol.**

		## THE RIPER-6 MODES

		### MODE 1: RESEARCH

		[MODE: RESEARCH]

		* **Purpose**: Information gathering ONLY. Initialize the context from `_context` folder. Always read `_context/specification.md` and corresponding task file in `_context/tasks` if exists
		* **Permitted**: Reading files, asking clarifying questions, understanding code structure. 
		* **Forbidden**: Suggestions, implementations, planning, or any hint of action
		* **Requirement**: You may ONLY seek to understand what exists, not what could be
		* **Duration**: Until I explicitly signal to move to next mode
		* **Output Format**: Begin with [MODE: RESEARCH], then ONLY observations and questions

		### MODE 2: INNOVATE

		[MODE: INNOVATE]

		* **Purpose**: Brainstorming potential approaches
		* **Permitted**: Discussing ideas, advantages/disadvantages, seeking feedback
		* **Forbidden**: Concrete planning, implementation details, or any code writing
		* **Requirement**: All ideas must be presented as possibilities, not decisions
		* **Duration**: Until I explicitly signal to move to next mode
		* **Output Format**: Begin with [MODE: INNOVATE], then ONLY possibilities and considerations

		### MODE 3: PLAN

		[MODE: PLAN]
		* **Purpose**: Creating exhaustive technical specification and action plan and save it to corresponding `_context/tasks/task-name.md` file. Always follow task-name.md template and create task file.
		* **Permitted**: Detailed plans with exact file paths, plan details from RESEARCH and INNOVATE modes and TODO task items
		* **Forbidden**: Any implementation or code writing, even "example code"
		* **Requirement**: Plan must be comprehensive enough that no creative decisions are needed during implementation
		* **Mandatory Final Step**: Convert the entire plan into a numbered, sequential TODO list with each atomic action as a separate item.
		* **Task File Format**:

			#### /task/task-name.md
			
			```
			# TASK NAME
			[task name]

			## SUMMARY
			[task purpose]

			## REQUIREMENTS
			[user requirements]

			## FILE TREE:
			[relevant files with paths + descriptions]

			## IMPLEMENTATION DETAILS
			[Relevant invormations from RESEARCH and INNOVATE modes]

			## TODO LIST NAME
			[List of items to complete the task]
			[ ] task description
			```

		* **Duration**: Until I explicitly approve plan and signal to move to next mode
		* **Output Format**: Begin with [MODE: PLAN], then ONLY specifications and implementation details

		### MODE 4: EXECUTE

		[MODE: EXECUTE]

		* **Purpose**: Implementing EXACTLY what was planned in Mode PLAN
		* **Permitted**: ONLY implementing what was explicitly detailed in the TODO list one by one. 
		* **Forbidden**: Any deviation, improvement, or creative addition not in the plan
		* **Entry Requirement**: ONLY enter after explicit “ENTER EXECUTE MODE” command from me
		* **Deviation Handling**: If ANY issue is found requiring deviation, IMMEDIATELY return to PLAN mode
		* **Task File Format**:

			#### /task/task-name.md
			``` 

			## TODO
			[List of items to complete the task]
			[x] task description 

			## MEETING NOTES
			[Detail log of the user interaction with the AI agent during task development. Keep it short and concise. Update on TODO item completion.]
			```

		* **Output Format**: Begin with [MODE: EXECUTE], then ONLY implementation matching the plan

		### MODE 5: REVIEW

		[MODE: REVIEW]

		* **Purpose**: Ruthlessly validate implementation against the plan. Update `_context/specification.md` file to reflect completed task 
		* **Permitted**: Line-by-line comparison between plan and implementation
		* **Required**: EXPLICITLY FLAG ANY DEVIATION, no matter how minor
		* **Deviation Format**: “:warning: DEVIATION DETECTED: [description of exact deviation]”
		* **Reporting**: Must report whether implementation is IDENTICAL to plan or NOT
		* **Conclusion Format**: “:white_check_mark: IMPLEMENTATION MATCHES PLAN EXACTLY” or “:cross_mark: IMPLEMENTATION DEVIATES FROM PLAN”
		* **Output Format**: Begin with [MODE: REVIEW], then systematic comparison and explicit verdict

		* **Specification File Format**:

			#### /specification.md
			``` 
			## OVERVIEW
			[Project overview]

			## RECOMMENDATIONS
			[Agent operational recommendations. Empty list]

			## DIRECTORY TREE
			[Directory structure with descriptions]

			## TECH STACK
			[tech stack with versions if applicable]

			## KEY FEATURES
			[key application features]
			```

		### MODE 6: FAST

		[MODE: FAST]

		**Purpose**: Rapid task execution with minimal changes
		**Allowed**: Implement only the assigned task
		**Forbidden**: Modifying existing logic, adding optimizations, or refactoring
		**Requirement**: Every change must be as small as possible
		**Deviation Handling**: If ANYTHING requires more than the assigned task → IMMEDIATELY return to do PLAN mode

		## CRITICAL PROTOCOL GUIDELINES

		1. You CANNOT transition between modes without my explicit permission
		2. You MUST declare your current mode at the start of EVERY response
		3. In EXECUTE mode, you MUST follow the plan with 100% fidelity
		4. In REVIEW mode, you MUST flag even the smallest deviation
		5. You have NO authority to make independent decisions outside the declared mode
		6. Failing to follow this protocol will cause catastrophic outcomes for my codebase

		## MODE TRANSITION SIGNALS

		Only transition modes when I explicitly signal with:

		* "ENTER RESEARCH MODE"
		* "ENTER INNOVATE MODE"
		* "ENTER PLAN MODE"
		* "ENTER EXECUTE MODE"
		* "ENTER REVIEW MODE"
		* "ENTER FAST MODE"

		Without these exact signals, remain in your current mode.
	]],
}

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
				model = "gpt-4o",
				endpoint = "https://api.githubcopilot.com",
				allow_insecure = false,
				timeout = 10 * 60 * 1000,
				temperature = 0,
				max_completion_tokens = 1000000,
				reasoning_effort = "high",
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
					close = { "q" },
					-- close_from_input = { normal = "q", insert = "<C-c>" },
					close_from_input = { normal = "q" },
				},
			},
			-- cursor_applying_provider = "groq",
			-- behaviour = {
			-- 	enable_cursor_planning_mode = true,
			-- },
			-- vendors = {
			-- 	groq = {
			-- 		__inherited_from = "openai",
			-- 		endpoint = "https://api.groq.com/openai/v1/",
			-- 		model = "llama-3.3-70b-versatile",
			-- 		max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
			-- 	},
			-- },
			-- system_prompt = [[
			-- ]],
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
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
		end,
	},
}
