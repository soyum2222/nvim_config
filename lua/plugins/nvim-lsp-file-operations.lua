return {
	{
		"antosha417/nvim-lsp-file-operations",
		-- 明确声明依赖，lazy.nvim 会确保加载顺序正确
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		-- config 函数会在插件加载后执行
		config = function()
			-- 调用 setup 函数来启用插件
			require("lsp-file-operations").setup()
			print("nvim-lsp-file-operations has been set up.") -- 加一个打印，方便确认
		end,
	}
}
