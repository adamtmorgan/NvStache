return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			vue = { "eslint_d" },
			kotlin = { "ktlint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- For linters that don't require save before linting
		-- For linters that do require save, make a separate autocommand for BufWritePost
		-- Check that linters here enable stdin for this to work:
		-- https://github.com/mfussenegger/nvim-lint/tree/master/lua/lint/linters
		vim.api.nvim_create_autocmd({
			"BufEnter",
			"TextChanged",
		}, {
			pattern = {
				"*.ts",
				"*.tsx",
				"*.js",
				"*.jsx",
				"*.vue",
				"*.kt",
			},
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
