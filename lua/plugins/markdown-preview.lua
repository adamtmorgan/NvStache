return {
	{
		-- install without yarn or npm
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "Avante" },
			code = {
				style = "normal",
				-- disable_background = true,
			}
		},
		ft = { "markdown", "Avante" },
	},
}
