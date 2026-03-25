return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim",           version = "^1.0.0" },
			{ "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
			"hrsh7th/nvim-cmp",        -- 自动补全引擎
			"hrsh7th/cmp-nvim-lsp",    -- LSP 补全源
			"hrsh7th/cmp-buffer",      -- 缓冲区补全源
			"hrsh7th/cmp-path",        -- 路径补全源
			"hrsh7th/cmp-cmdline",     -- 命令行补全源
			"L3MON4D3/LuaSnip",        -- 代码片段引擎
			"saadparwaiz1/cmp_luasnip", -- LuaSnip 补全源
			"nvim-lua/plenary.nvim",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			local builtin = require("telescope.builtin")
			local snip = require("luasnip")

			-- 自动补全配置
			local cmp = require("cmp")
			cmp.setup({
				preselect = cmp.PreselectMode.None,
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
					{ name = "luasnip" },  -- 代码片段
					{ name = "nvim_lsp" }, -- LSP 补全
					{ name = "buffer" },   -- 缓冲区补全
					{ name = "path" },     -- 路径补全
				}),
			})

			-- 加载 Mason
			require("mason").setup()

			-- 全局 capabilities（对所有 LSP 生效）
			-- 使用 vim.lsp.config('*', ...) 设置通用配置（Neovim 0.11+ 新 API）
			vim.lsp.config('*', {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- gopls 配置
			vim.lsp.config('gopls', {
				settings = {
					gopls = {
						analyses = {
							unusedparams  = true, -- 未使用参数检查
							shadow        = true, -- 变量遮蔽检查
							nilness       = true, -- nil dereference 检查
							printf        = true, -- 格式化字符串检查
							composites    = true, -- 未使用的结构体字段检查
							unreachable   = true, -- 无法访问的代码检查
							deprecated    = true, -- 已弃用 API 检查
							unusedresult  = true,
						},
						staticcheck = true,
						gofumpt = true,
						codelenses = {
							gc_details         = false,
							generate           = true,
							regenerate_cgo     = true,
							run_govulncheck    = true,
							test               = true,
							tidy               = true,
							upgrade_dependency = true,
							vendor             = true,
						},
						hints = {
							assignVariableTypes     = true,
							compositeLiteralFields  = true,
							compositeLiteralTypes   = true,
							constantValues          = true,
							functionTypeParameters  = true,
							parameterNames          = true,
							rangeVariableTypes      = true,
						},
						usePlaceholders     = true,
						completeUnimported  = true,
						directoryFilters    = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-.nvim" },
						semanticTokens      = true,
					},
				},
			})

			-- ts_ls 配置
			vim.lsp.config('ts_ls', {
				-- 正确识别项目根目录，LSP 能索引整个项目
				root_dir = require("lspconfig").util.root_pattern(
					"package.json",  -- npm/yarn 项目
					"tsconfig.json", -- TypeScript 项目
					"jsconfig.json", -- JavaScript 项目
					".git"           -- git 仓库根目录
				),
				single_file_support = true,
				init_options = {
					preferences = {
						importModuleSpecifierPreference          = "relative",
						includeCompletionsForModuleExports       = true,
						includeAutomaticOptionalChainCompletions = true,
					},
				},
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints                = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints        = true,
							includeInlayVariableTypeHints                 = true,
							includeInlayPropertyDeclarationTypeHints      = true,
							includeInlayFunctionLikeReturnTypeHints       = true,
							includeInlayEnumMemberValueHints              = true,
						},
						format = {
							indentSize           = 2,
							tabSize              = 2,
							convertTabsToSpaces  = true,
						},
						suggest = {
							completeFunctionCalls = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints                = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints        = true,
							includeInlayVariableTypeHints                 = true,
							includeInlayPropertyDeclarationTypeHints      = true,
							includeInlayFunctionLikeReturnTypeHints       = true,
							includeInlayEnumMemberValueHints              = true,
						},
						format = {
							indentSize           = 2,
							tabSize              = 2,
							convertTabsToSpaces  = true,
						},
						suggest = {
							completeFunctionCalls = true,
						},
					},
				},
			})

			-- rust-analyzer 配置（优先使用 mason 安装的版本）
			local mason_ra = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"
			local ra_cmd = (vim.fn.executable(mason_ra) == 1) and mason_ra or "rust-analyzer"
			vim.lsp.config('rust_analyzer', {
				cmd = { ra_cmd },
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						checkOnSave = {
							command = "clippy",
						},
						procMacro = {
							enable = true,
						},
					},
				},
			})

			-- 所有 vim.lsp.config() 调用完毕后，显式启用各 LSP
			-- 打开对应 filetype 的文件时会自动连接相应 LSP
			vim.lsp.enable({ 'gopls', 'lua_ls', 'pyright', 'ts_ls', 'rust_analyzer' })

			-- mason-lspconfig：确保 LSP 已安装
			require("mason-lspconfig").setup({
				automatic_enable = false, -- 已通过 vim.lsp.enable() 显式启用，关闭自动启用
				ensure_installed = { "gopls", "lua_ls", "pyright", "ts_ls", "rust_analyzer" },
			})

			-- LSP 快捷键绑定
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "<leader>r",  vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "gD",         vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd",         builtin.lsp_definitions, opts)
					vim.keymap.set("n", "K",          vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi",         builtin.lsp_implementations, opts)
					vim.keymap.set("n", "<C-k>",      vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa",  vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr",  vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl",  function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D",   vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn",  vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr",         builtin.lsp_references, opts)
					vim.keymap.set("n", "<space>f",   function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			-- 诊断图标
			vim.fn.sign_define({
				{ name = "DiagnosticSignError", text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" },
				{ name = "DiagnosticSignWarn",  text = "", texthl = "DiagnosticSignWarn",  linehl = "", numhl = "" },
				{ name = "DiagnosticSignInfo",  text = "", texthl = "DiagnosticSignInfo",  linehl = "", numhl = "" },
				{ name = "DiagnosticSignHint",  text = "", texthl = "DiagnosticSignHint",  linehl = "", numhl = "" },
			})

			-- 诊断显示配置
			vim.diagnostic.config({
				signs            = true,
				virtual_text     = false,
				update_in_insert = false,
			})
		end,
	},
}
