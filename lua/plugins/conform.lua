return {
	{
		"stevearc/conform.nvim",
		opts = {},

		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					go = { "goimports", "gofmt" },
					json = { "fixjson",  stop_after_first = true },
				},
				formatters = {
					-- 配置 prettier 使用 2 个空格缩进
					prettier = {
						prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
					},
					prettierd = {
						prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
					},
				},
			})
		end,
	},
}
