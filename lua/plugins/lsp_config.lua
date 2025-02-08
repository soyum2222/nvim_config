return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim", -- LSP 服务器管理工具
			"williamboman/mason-lspconfig.nvim", -- Mason 和 lspconfig 的桥梁
			"hrsh7th/nvim-cmp", -- 自动补全引擎
			"hrsh7th/cmp-nvim-lsp", -- LSP 补全源
			"hrsh7th/cmp-buffer", -- 缓冲区补全源
			"hrsh7th/cmp-path", -- 路径补全源
			"hrsh7th/cmp-cmdline", -- 命令行补全源
			"L3MON4D3/LuaSnip", -- 代码片段引擎
			"saadparwaiz1/cmp_luasnip", -- LuaSnip 补全源
			"jose-elias-alvarez/null-ls.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()

			local builtin = require("telescope.builtin")
			-- 加载 Mason 并配置
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls" }, -- 确保 gopls 已安装
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 加载 lspconfig 并配置 gopls
			local lspconfig = require("lspconfig")
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			-- 自动补全配置
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<A-b>"] = cmp.mapping.scroll_docs(-4),
					["<A-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP 补全
					{ name = "luasnip" }, -- 代码片段
					{ name = "buffer" }, -- 缓冲区补全
					{ name = "path" }, -- 路径补全
				}),
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.isort,
					 --null_ls.builtins.formatting.autoflake,
				},
			})

			-- LSP 快捷键绑定
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }

					-- 重命名变量
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", builtin.lsp_references, opts)
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			vim.fn.sign_define({
				{
					name = "DiagnosticSignError",
					text = "", -- 错误图标（需要支持图标的字体，如 Nerd Font）
					texthl = "DiagnosticSignError", -- 高亮组（颜色）
					linehl = "",
					numhl = "",
				},
				{
					name = "DiagnosticSignWarn",
					text = "", -- 警告图标
					texthl = "DiagnosticSignWarn",
					linehl = "",
					numhl = "",
				},
				{
					name = "DiagnosticSignInfo",
					text = "", -- 信息图标
					texthl = "DiagnosticSignInfo",
					linehl = "",
					numhl = "",
				},
				{
					name = "DiagnosticSignHint",
					text = "", -- 提示图标
					texthl = "DiagnosticSignHint",
					linehl = "",
					numhl = "",
				},
			})

			-- 设置诊断符号的显示方式
			vim.diagnostic.config({
				signs = true, -- 启用诊断符号
				virtual_text = false, -- 禁用行内虚拟文本（可选）
				update_in_insert = false, -- 不在插入模式下更新诊断
			})
			-- General/Global LSP Configuration
		end,
	},
}
