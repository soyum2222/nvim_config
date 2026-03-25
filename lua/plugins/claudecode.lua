-- claudecode.nvim - 官方 Claude Code Neovim 集成插件
-- 提供与 Claude Code CLI 的完整 IDE 集成体验
-- 仓库: https://github.com/coder/claudecode.nvim
return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		event = "VeryLazy",
		opts = {
			-- 日志级别: "trace", "debug", "info", "warn", "error"
			log_level = "info",

			-- 自动启动 Claude Code 连接
			auto_start = true,

			-- 终端配置
			terminal = {
				-- 分割方向: "left" 或 "right"
				split_side = "right",
				-- 分割宽度占比 (0.0 - 1.0)
				split_width_percentage = 0.35,
				-- 终端提供者: "auto", "snacks", "native"
				provider = "auto",
				-- 关闭 Claude 时自动关闭终端
				auto_close = true,
			},

			-- 差异对比配置
			diff_opts = {
				-- 布局: "vertical" 或 "horizontal"
				layout = "vertical",
				-- 在新标签页中打开差异
				open_in_new_tab = false,
			},
		},
		config = function(_, opts)
			require("claudecode").setup(opts)
		end,
		-- 快捷键配置
		keys = {
			-- 打开/切换 Claude Code
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
			-- 聚焦 Claude Code 窗口
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
			-- 恢复 Claude Code 会话
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude Session" },
			-- 继续 Claude Code 会话
			{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude Session" },
			-- 选择 Claude 模型
			{ "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude Model" },
			-- 将当前缓冲区添加到 Claude 上下文
			{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer to Claude" },
			-- 发送可视选择到 Claude
			{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Selection to Claude" },
			-- 接受差异
			{ "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude Diff" },
			-- 拒绝差异
			{ "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude Diff" },
		},
		-- 懒加载命令
		cmd = {
			"ClaudeCode",
			"ClaudeCodeFocus",
			"ClaudeCodeSend",
			"ClaudeCodeAdd",
			"ClaudeCodeDiffAccept",
			"ClaudeCodeDiffDeny",
			"ClaudeCodeSelectModel",
		},
	},
}
