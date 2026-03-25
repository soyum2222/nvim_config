return {
	{

		"lewis6991/gitsigns.nvim",
		opts = {

			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 100,
				ignore_whitespace = false,
			},
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},

			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- stylua: ignore start
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
				map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local actions = require("diffview.actions")
			
			require("diffview").setup({
				enhanced_diff_hl = true, -- 增强的高亮
				use_icons = true,
				show_help_hints = true, -- 显示帮助提示
				
				-- 文件面板配置
				file_panel = {
					listing_style = "tree", -- 'list' 或 'tree'
					tree_options = {
						flatten_dirs = true,
						folder_statuses = "only_folded",
					},
					win_config = {
						position = "left",
						width = 35,
					},
				},
				
				-- 文件历史面板配置
				file_history_panel = {
					win_config = {
						position = "bottom",
						height = 16,
					},
				},
				
				-- Commit 日志面板
				commit_log_panel = {
					win_config = {
						position = "bottom",
						height = 16,
					},
				},
				
				-- 合并工具配置（重点！）
				merge_tool = {
					-- 布局: 'diff1_plain', 'diff2_horizontal', 'diff2_vertical', 'diff3_horizontal', 'diff3_vertical', 'diff3_mixed', 'diff4_mixed'
					layout = "diff3_mixed", -- 推荐：三向合并 + 结果窗口
					disable_diagnostics = true, -- 合并时禁用诊断
					continuous_layout = true,
				},
				
				-- 快捷键配置
				keymaps = {
					disable_defaults = false,
					view = {
						-- 导航
						{ "n", "<tab>",      actions.select_next_entry,         { desc = "下一个文件" } },
						{ "n", "<s-tab>",    actions.select_prev_entry,         { desc = "上一个文件" } },
						{ "n", "gf",         actions.goto_file_edit,            { desc = "在当前窗口打开文件" } },
						{ "n", "<C-w><C-f>", actions.goto_file_split,           { desc = "在分割窗口打开" } },
						{ "n", "<C-w>gf",    actions.goto_file_tab,             { desc = "在新标签页打开" } },
						{ "n", "<leader>e",  actions.focus_files,               { desc = "聚焦文件面板" } },
						{ "n", "<leader>b",  actions.toggle_files,              { desc = "切换文件面板" } },
						
						-- Diff 操作
						{ "n", "g<C-x>",     actions.cycle_layout,              { desc = "切换布局" } },
						{ "n", "[x",         actions.prev_conflict,             { desc = "上一个冲突" } },
						{ "n", "]x",         actions.next_conflict,             { desc = "下一个冲突" } },
						{ "n", "<leader>co", actions.conflict_choose("ours"),   { desc = "当前冲突选择我们的版本 (OURS)" } },
						{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "当前冲突选择他们的版本 (REMOTE)" } },
						{ "n", "co",         actions.conflict_choose("ours"),   { desc = "当前冲突选择我们的版本 (OURS)" } },
						{ "n", "ct",         actions.conflict_choose("theirs"), { desc = "当前冲突选择他们的版本 (REMOTE)" } },
						{ "n", "<leader>cb", actions.conflict_choose("base"),   { desc = "选择基础版本 (LOCAL)" } },
						{ "n", "<leader>ca", actions.conflict_choose("all"),    { desc = "保留所有版本" } },
						{ "n", "dx",         actions.conflict_choose("none"),   { desc = "删除冲突区域" } },
						{ "n", "<leader>cO", actions.conflict_choose_all("ours"),   { desc = "所有冲突选择 ours" } },
						{ "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "所有冲突选择 theirs" } },
						{ "n", "<leader>cB", actions.conflict_choose_all("base"),   { desc = "所有冲突选择 base" } },
						{ "n", "<leader>cA", actions.conflict_choose_all("all"),    { desc = "所有冲突保留全部" } },
						{ "n", "dX",         actions.conflict_choose_all("none"),   { desc = "删除所有冲突" } },
					},
					
					file_panel = {
						{ "n", "j",             actions.next_entry,           { desc = "下一个" } },
						{ "n", "k",             actions.prev_entry,           { desc = "上一个" } },
						{ "n", "<cr>",          actions.select_entry,         { desc = "打开 diff" } },
						{ "n", "-",             actions.toggle_stage_entry,   { desc = "Stage/unstage 文件" } },
						{ "n", "S",             actions.stage_all,            { desc = "Stage 所有" } },
						{ "n", "U",             actions.unstage_all,          { desc = "Unstage 所有" } },
						{ "n", "X",             actions.restore_entry,        { desc = "恢复文件" } },
						{ "n", "L",             actions.open_commit_log,      { desc = "打开 commit 日志" } },
						{ "n", "zo",            actions.open_fold,            { desc = "展开" } },
						{ "n", "zc",            actions.close_fold,           { desc = "折叠" } },
						{ "n", "za",            actions.toggle_fold,          { desc = "切换折叠" } },
						{ "n", "zR",            actions.open_all_folds,       { desc = "展开所有" } },
						{ "n", "zM",            actions.close_all_folds,      { desc = "折叠所有" } },
						{ "n", "<c-b>",         actions.scroll_view(-0.25),   { desc = "向上滚动 25%" } },
						{ "n", "<c-f>",         actions.scroll_view(0.25),    { desc = "向下滚动 25%" } },
						{ "n", "<tab>",         actions.select_next_entry,    { desc = "下一个文件" } },
						{ "n", "<s-tab>",       actions.select_prev_entry,    { desc = "上一个文件" } },
						{ "n", "gf",            actions.goto_file_edit,       { desc = "打开文件" } },
						{ "n", "<C-w><C-f>",    actions.goto_file_split,      { desc = "分割窗口打开" } },
						{ "n", "<C-w>gf",       actions.goto_file_tab,        { desc = "新标签打开" } },
						{ "n", "i",             actions.listing_style,        { desc = "切换 tree/list" } },
						{ "n", "f",             actions.toggle_flatten_dirs,  { desc = "切换扁平目录" } },
						{ "n", "R",             actions.refresh_files,        { desc = "刷新" } },
						{ "n", "<leader>e",     actions.focus_files,          { desc = "聚焦文件" } },
						{ "n", "<leader>b",     actions.toggle_files,         { desc = "切换面板" } },
						{ "n", "g<C-x>",        actions.cycle_layout,         { desc = "切换布局" } },
						{ "n", "[x",            actions.prev_conflict,        { desc = "上一个冲突" } },
						{ "n", "]x",            actions.next_conflict,        { desc = "下一个冲突" } },
						{ "n", "g?",            actions.help("file_panel"),   { desc = "帮助" } },
					},
					
					file_history_panel = {
						{ "n", "g!",            actions.options,              { desc = "选项" } },
						{ "n", "<C-A-d>",       actions.open_in_diffview,     { desc = "在 diffview 打开" } },
						{ "n", "y",             actions.copy_hash,            { desc = "复制 commit hash" } },
						{ "n", "L",             actions.open_commit_log,      { desc = "打开 commit 日志" } },
						{ "n", "zR",            actions.open_all_folds,       { desc = "展开所有" } },
						{ "n", "zM",            actions.close_all_folds,      { desc = "折叠所有" } },
						{ "n", "j",             actions.next_entry,           { desc = "下一个" } },
						{ "n", "k",             actions.prev_entry,           { desc = "上一个" } },
						{ "n", "<cr>",          actions.select_entry,         { desc = "打开 diff" } },
						{ "n", "<tab>",         actions.select_next_entry,    { desc = "下一个文件" } },
						{ "n", "<s-tab>",       actions.select_prev_entry,    { desc = "上一个文件" } },
						{ "n", "gf",            actions.goto_file_edit,       { desc = "打开文件" } },
						{ "n", "<C-w><C-f>",    actions.goto_file_split,      { desc = "分割窗口打开" } },
						{ "n", "<C-w>gf",       actions.goto_file_tab,        { desc = "新标签打开" } },
						{ "n", "<leader>e",     actions.focus_files,          { desc = "聚焦文件" } },
						{ "n", "<leader>b",     actions.toggle_files,         { desc = "切换面板" } },
						{ "n", "g<C-x>",        actions.cycle_layout,         { desc = "切换布局" } },
						{ "n", "g?",            actions.help("file_history_panel"), { desc = "帮助" } },
					},
					
					option_panel = {
						{ "n", "<tab>", actions.select_entry,          { desc = "改变值" } },
						{ "n", "q",     actions.close,                 { desc = "关闭" } },
						{ "n", "g?",    actions.help("option_panel"),  { desc = "帮助" } },
					},
				},
			})
			
			-- 全局快捷键
			vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "打开 Diffview" })
			vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { desc = "关闭 Diffview" })
			vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "文件历史" })
			vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", { desc = "当前文件历史" })
			vim.keymap.set("n", "<leader>gm", "<cmd>DiffviewOpen origin/main...HEAD<CR>", { desc = "与 main 比较" })
			vim.keymap.set("n", "<leader>gM", "<cmd>DiffviewOpen HEAD~1<CR>", { desc = "与上次 commit 比较" })
			
			-- Merge 冲突解决快捷键（在非 diffview 中使用）
			vim.keymap.set("n", "<leader>gco", "<cmd>diffget //2<CR>", { desc = "选择 ours (当前分支)" })
			vim.keymap.set("n", "<leader>gct", "<cmd>diffget //3<CR>", { desc = "选择 theirs (合并分支)" })
			
			print("Diffview (Git Merge Tool) 已加载")
		end,
	},
	{
		"rbong/vim-flog",
	},

	{
		"FabijanZulj/blame.nvim",
		config = function()
			require("blame").setup({})
		end,
	},
	{

		"tpope/vim-fugitive",
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"echasnovski/mini.pick", -- optional
		},
		config = true,
	},

	{
		--"kdheepak/lazygit.nvim",
		--lazy = true,
		--cmd = {
		--        "LazyGit",
		--        "LazyGitConfig",
		--        "LazyGitCurrentFile",
		--        "LazyGitFilter",
		--        "LazyGitFilterCurrentFile",
		--},
		---- optional for floating window border decoration
		--dependencies = {
		--        "nvim-lua/plenary.nvim",
		--},
		---- setting the keybinding for LazyGit with 'keys' is recommended in
		---- order to load the plugin when the command is run for the first time
		--keys = {
		--        { "<leader>gg", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit" },
		--},

		--config = function()
		--        --require("telescope").load_extension("lazygit")

		--        --vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
		--end,
	},
}
