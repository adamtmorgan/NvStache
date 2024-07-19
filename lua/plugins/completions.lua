return {
	--------------------------------------------------
	-- Handles the popup window for autocomplete
	--------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			-- Loads in the "friendly-snippets" from snippet manager
			-- in next table.
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = { completeopt = "menu,menuone,noinsert" },
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.scroll_docs(-4),
					["<C-n>"] = cmp.mapping.scroll_docs(4),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = "vsnip" }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Setup up vim-dadbod (db client)
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})

			-- Added to support cmp-cmdline
			-- Use buffer source for `/` (search) and `?` (reverse search).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (command line).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Add key bindings for navigation completions in command mode
			vim.keymap.set("c", "<C-j>", cmp.mapping.select_next_item(), {})
			vim.keymap.set("c", "<C-k>", cmp.mapping.select_prev_item(), {})

			vim.cmd("highlight LspSignatureActiveParameter guifg=#ff0000 guibg=none")
		end,
	},
	--------------------------------------------------
	-- Handles LSP as source for completions
	--------------------------------------------------
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = "rounded",
				},
				floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
				hint_enable = true, -- virtual hint enable
				hint_prefix = "🐼 ", -- Panda for parameter hint
				hi_parameter = "Search", -- Highlight for current parameter
			})
		end,
	},
	--------------------------------------------------
	-- Handles LSP as source for completions
	--------------------------------------------------
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	--------------------------------------------------
	-- Handles snippet management
	--------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

	--------------------------------------------------
	-- Supplies command line and search completions
	-- sources for nvim-cpm.
	--------------------------------------------------
	{
		"hrsh7th/cmp-cmdline",
	},
}
