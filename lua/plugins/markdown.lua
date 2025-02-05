return {

	{
		"iamcco/markdown-preview.nvim",
		tag = "v0.0.10",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	}

}
