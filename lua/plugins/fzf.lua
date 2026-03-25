return {
	{
		"ibhagwan/fzf-lua",

		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {},

	config = function()
		local actions = require("fzf-lua.actions")
		require("fzf-lua").setup({
			keymap = {
				fzf = {
					-- Ctrl+A: 选择/取消选择所有
					["ctrl-a"] = "toggle-all",
				},
			},
			actions = {
				-- 文件搜索的 actions
				files = {
					-- Ctrl+Q: 把选中的文件发送到 quickfix
					["ctrl-q"] = actions.file_sel_to_qf,
					["enter"] = actions.file_edit_or_qf,
				},
				-- grep/搜索结果的 actions
				grep = {
					-- Ctrl+Q: 把选中的搜索结果发送到 quickfix
					["ctrl-q"] = actions.file_sel_to_qf,
					["enter"] = actions.file_edit_or_qf,
				},
			},
			-- 默认设置：在使用 Ctrl+Q 发送到 quickfix 后自动打开 quickfix 窗口
			fzf_opts = {
				["--layout"] = "reverse",
			},
		})
	end,
	},
}
