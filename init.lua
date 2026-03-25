if vim.g.vscode then
	-- VSCode extension
	require("config.lazy")
else
	local api = vim.api
	local lsp = vim.lsp

	local make_client_capabilities = lsp.protocol.make_client_capabilities
	function lsp.protocol.make_client_capabilities()
		local caps = make_client_capabilities()
		if not (caps.workspace or {}).didChangeWatchedFiles then
			vim.notify("lsp capability didChangeWatchedFiles is already disabled", vim.log.levels.WARN)
		else
			caps.workspace.didChangeWatchedFiles = nil
		end

		return caps
	end

	require("config.lazy")

	vim.cmd([[
	set clipboard=unnamed
	"set relativenumber
	set number
	set tabstop=8
	set incsearch
	set mouse=a
	set fileencodings=utf-8,gbk
	"set ff=unix

	set completeopt-=preview
	set completeopt-=menu

	hi      NvimTreeExecFile    guifg=#ffa0a0
	hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
	hi      NvimTreeSymlink     guifg=Yellow  gui=italic
	hi link NvimTreeImageFile   Title
	]])

	-- Node.js/JavaScript/TypeScript 文件的缩进配置（2 个空格）
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
		callback = function()
			vim.opt_local.shiftwidth = 2    -- 缩进宽度
			vim.opt_local.tabstop = 2       -- Tab 显示宽度
			vim.opt_local.softtabstop = 2   -- 按 Tab 键插入的空格数
			vim.opt_local.expandtab = true  -- 使用空格代替 Tab
		end,
	})

	vim.keymap.set("n", "[c", function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end, { silent = true })

	vim.g.snacks_animate = false

	vim.keymap.set("n", "]g", function()
		vim.diagnostic.goto_next()
	end, { desc = "Go to next diagnostic" })

	vim.keymap.set("n", "[g", function()
		vim.diagnostic.goto_prev()
	end, { desc = "Go to previous diagnostic" })

	vim.cmd([[set termguicolors ]])
	vim.cmd([[set cursorline]])

	--vim.cmd([[highlight CursorLine cterm=NONE ctermbg=DarkCyan guibg=#718871]])

	--vim.cmd [[colorscheme tokyonight]]

	--vim.cmd([[ nnoremap <F2> :Neotree toggle<cr> ]])
	vim.cmd([[ nnoremap <F2> :NvimTreeToggle<cr> ]])

	--vim.cmd([[ autocmd VimEnter * Neotree toggle<cr> ]])
	--vim.cmd([[ autocmd VimEnter * NvimTreeToggle ]])

	-- key maps
	--
	vim.cmd([[ noremap <F7> :lua require'dap'.step_into()<CR> ]])

	vim.cmd([[ noremap <F8> :lua require'dap'.step_over()<CR> ]])
	vim.cmd([[ noremap <F9> :lua require'dap'.continue()<CR>  ]])

	vim.cmd([[ noremap <leader>- :lua tabprev()<CR>]])

	vim.cmd([[ noremap <leader>= :lua tabnext()<CR>]])

	vim.cmd([[ noremap <A--> <cmd>lua bufprev()<CR>]])
	vim.cmd([[ inoremap <A--> <cmd>lua bufprev()<CR>]])

	vim.cmd([[ noremap <A-=> <cmd>lua bufnext()<CR>]])
	vim.cmd([[ inoremap <A-=> <cmd>lua bufnext()<CR>]])

	vim.cmd([[ noremap ≠ <cmd>lua bufnext()<CR>]])
	vim.cmd([[ inoremap ≠ <cmd>lua bufnext()<CR>]])

	vim.cmd([[ noremap – <cmd>lua bufprev()<CR>]])
	vim.cmd([[ inoremap – <cmd>lua bufprev()<CR>]])

	vim.cmd([[ noremap <leader><tab> :lua bufswitch()<CR> <CR>]])

	vim.cmd([[ noremap <leader>b :lua require'dap'.toggle_breakpoint()<CR>]])
	vim.cmd([[ noremap <leader>c :lua DapDebug()<CR>]])

	vim.cmd([[ noremap <leader>d :lua require("dapui").toggle()<CR>]])

	vim.cmd([[ noremap <leader>s :lua require("dapui").eval()<CR>]])

	vim.cmd(
		[[ noremap <leader>w :lua local widgets =  require('dap.ui.widgets'); widgets.centered_float(widgets.scopes)<CR>]]
	)

	vim.cmd([[ noremap <leader>g :G<CR>]])
	vim.cmd([[ noremap <leader>gbl :BlameToggle virtual<CR>]])

	vim.cmd([[ noremap <leader>im :lua require'telescope'.extensions.goimpl.goimpl{}<CR>]])
	vim.cmd([[ nnoremap <C-d> 15j]])
	vim.cmd([[ vnoremap <C-d> 15j]])
	vim.cmd([[ nnoremap <C-u> 15k]])
	vim.cmd([[ vnoremap <C-u> 15k]])

	--vim.cmd([[noremap <leader><F6> :lua vim.lsp.buf.rename()<CR>]])
	vim.cmd([[noremap <leader>q :BufferClose<cr>]])

	-- Ctrl+S 格式化整个文件
	vim.cmd([[imap <C-s> <cmd>lua FileFmt(true)<CR>]])
	vim.cmd([[noremap <C-s> <cmd>lua FileFmt(true)<CR>]])

	-- Leader+Ctrl+S 只格式化 git 修改的部分
	vim.cmd([[imap <leader><C-s> <cmd>lua FileFmt()<CR>]])
	vim.cmd([[noremap <leader><C-s> <cmd>lua FileFmt()<CR>]])

	vim.cmd([[noremap <C-r> :lua require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) <CR>]])
	vim.cmd(
		[[vmap <C-r> :lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) <CR> ]]
	)

	-- go map

	vim.cmd([[noremap <leader><CR> :GoFillStruct<CR>]])
	vim.cmd([[noremap <leader>` :GoAddTags json yaml<CR>]])

	vim.cmd([[map <A-/> <plug>NERDCommenterToggle]])
	vim.cmd([[map ÷ <plug>NERDCommenterToggle]])
	vim.cmd([[nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep({cwd=FilePath()})<cr>]])
	vim.cmd([[nnoremap <leader><C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>]])
	--vim.cmd([[nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>]])

	--vim.cmd([[nnoremap <leader><F1> <cmd>Neotree reveal<cr>]])
	vim.cmd([[nnoremap <leader><F1> <cmd>NvimTreeFindFile<cr>]])

	vim.cmd([[map <A-/> <plug>NERDCommenterToggle]])
	vim.cmd([[map ÷ <plug>NERDCommenterToggle]])

	vim.cmd([[nnoremap <leader>ff <cmd>FzfLua lgrep_curbuf <cr>]])
	--vim.cmd([[nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep({cwd=FilePath()})<cr>]])
	vim.cmd([[nnoremap <leader><C-f> <cmd>FzfLua live_grep<cr>]])
	--vim.cmd([[nnoremap <leader><C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>]])
	--vim.cmd([[nnoremap <leader>f <cmd>FzfLua files<cr>]])
	vim.cmd([[nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>]])

	-- 快速搜索光标下的词（用于查找函数引用等）
	-- vim.keymap.set("n", "<leader>fw", function()
	-- 	local word = vim.fn.expand("<cword>")
	-- 	require("fzf-lua").live_grep({ search = word })
	-- end, { desc = "搜索光标下的词" })

	--vim.cmd([[nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>]])

	-- compatible windows terminal
	vim.cmd([[noremap  :tabnew<CR>]])
	vim.cmd([[noremap tabp<CR>]])
	vim.cmd([[noremap  :tabn<CR>]])

	vim.cmd([[nnoremap † :lua Snacks.terminal()<cr>]])
	vim.cmd([[nnoremap <A-t> :lua Snacks.terminal()<cr>]])

	vim.cmd(
		[[command DebugW lua local widgets = require('dap.ui.widgets');local my_sidebar = widgets.sidebar(widgets.scopes);my_sidebar.open();local widgets = require('dap.ui.widgets');local my_sidebar = widgets.sidebar(widgets.frames);my_sidebar.open();]]
	)

	vim.g.neovide_input_use_logo = 1
	--vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
	--vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	--vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	--vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

	--vim.api.nvim_set_keymap("", "<S-Insert>", "+p<CR>", { noremap = true, silent = true })
	--vim.api.nvim_set_keymap("!", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
	--vim.api.nvim_set_keymap("t", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
	--vim.api.nvim_set_keymap("v", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })

	if vim.g.neovide then
		vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<D-v>", function()
			vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
		end, { noremap = true, silent = true })

		vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<S-Insert>", function()
			vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
		end, { noremap = true, silent = true })

		vim.g.neovide_cursor_vfx_mode = "ripple"
	end

	function tabnew()
		last_tab = vim.api.nvim_get_current_tabpage()
		vim.api.nvim_command("tabnew")
	end

	function tabnext()
		last_tab = vim.api.nvim_get_current_tabpage()
		vim.api.nvim_command("tabnext")
	end

	function tabnew()
		last_tab = vim.api.nvim_get_current_tabpage()
		vim.api.nvim_command("tabnew")
	end

	function tabnext()
		last_tab = vim.api.nvim_get_current_tabpage()
		vim.api.nvim_command("tabnext")
	end

	function tabprev()
		last_tab = vim.api.nvim_get_current_tabpage()
		vim.api.nvim_command("tabprev")
	end

	function tabswitch()
		local_last_tab = vim.api.nvim_get_current_tabpage()
		vim.api.nvim_set_current_tabpage(last_tab)
		last_tab = local_last_tab
	end

	function bufnext()
		--last_buffer = vim.fn.bufnr("%")
		--print(last_buffer)
		vim.api.nvim_command("BufferNext")
		--vim.api.nvim_command("BufferLineCycleNext")
	end

	function bufprev()
		--last_buffer = vim.fn.bufnr("%")
		--print(last_buffer)
		vim.api.nvim_command("BufferPrevious")
		--vim.api.nvim_command("BufferLineCyclePrev")
	end

	-- 切换到上一次的标签页
	function bufswitch()
		--local_last_buffer = vim.fn.bufnr("%")
		--vim.cmd("buffer " .. last_buffer)
		--last_buffer = local_last_buffer
		--
		vim.api.nvim_command("Telescope oldfiles")
	end

	-- 获取 git 修改的行范围
	function GetGitDiffRanges()
		local file_path = vim.fn.expand("%:p")
		local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " rev-parse --show-toplevel")[1]
		
		if vim.v.shell_error ~= 0 then
			return nil -- 不在 git 仓库中
		end

		local relative_path = vim.fn.fnamemodify(file_path, ":.")
		local diff_output = vim.fn.systemlist("git diff -U0 HEAD -- " .. vim.fn.shellescape(relative_path))
		
		if vim.v.shell_error ~= 0 or #diff_output == 0 then
			return nil -- 文件没有修改
		end

		local ranges = {}
		for _, line in ipairs(diff_output) do
			-- 解析 @@ -a,b +c,d @@ 格式
			local start_line, line_count = line:match("^@@.*%+(%d+),?(%d*)%s@@")
			if start_line then
				start_line = tonumber(start_line)
				line_count = tonumber(line_count) or 1
				if line_count > 0 then
					table.insert(ranges, { start_line, start_line + line_count - 1 })
				end
			end
		end

		return #ranges > 0 and ranges or nil
	end

	-- 格式化函数：支持只格式化 git 修改的部分
	function FileFmt(only_git_changes)
		local file_type = vim.bo.filetype

		-- Go 文件使用特殊的格式化方式
		if file_type == "go" then
			require("go.format").goimports()
			return
		end

		-- 如果指定只格式化 git 修改的部分
		if only_git_changes then
			local ranges = GetGitDiffRanges()
			if ranges == nil then
				print("没有 git 修改或不在 git 仓库中，格式化整个文件")
				return
			else
				print("只格式化 git 修改的 " .. #ranges .. " 个区域")
				for _, range in ipairs(ranges) do
					require("conform").format({
						async = false,
						lsp_fallback = true,
						range = {
							start = { range[1], 0 },
							["end"] = { range[2], 0 },
						},
					})
				end
				print("Git 修改区域格式化完成!")
				return
			end
		end

		-- 格式化整个文件
		require("conform").format({
			async = true,
			lsp_fallback = true,
		}, function()
			print("整个文件格式化完成!")
		end)
	end

	--function tabprev()
	--        last_tab = vim.api.nvim_get_current_tabpage()
	--        vim.api.nvim_command("tabprev")
	--end

	--function tabswitch()
	--        local_last_tab = vim.api.nvim_get_current_tabpage()
	--        vim.api.nvim_set_current_tabpage(last_tab)
	--        last_tab = local_last_tab
	--end

	--function bufnext()
	--        last_buffer = vim.fn.bufnr("%")
	--        print(last_buffer)
	--        vim.api.nvim_command("BufferNext")
	--end

	--function bufprev()
	--        last_buffer = vim.fn.bufnr("%")
	--        print(last_buffer)

	--        vim.api.nvim_command("BufferPrevious")
	--end

	-- 切换到上一次的标签页
	--function bufswitch()
	--        local_last_buffer = vim.fn.bufnr("%")
	--        vim.cmd("buffer " .. last_buffer)
	--        last_buffer = local_last_buffer
	--end

	-- 注意：FileFmt() 函数已在上面第 251 行定义，使用 conform 格式化

	local Menu = require("nui.menu")
	local git_menu = Menu({
		position = "50%",
		size = {
			width = 50,
			height = 20,
		},
		border = {
			style = "single",
			text = {
				top = "[Git Menu]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = {
			Menu.item("Git blame"),
			Menu.item("Git diffview file history"),
			Menu.item("Git log"),
			Menu.item("cancel"),
		},
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			print("Menu Closed!")
		end,
		on_submit = function(item)
			if item.text == "Git blame" then
				vim.cmd("BlameToggle virtual")
			end
			if item.text == "Git diffview file history" then
				vim.cmd("DiffviewFileHistory %")
			end
			if item.text == "Git log" then
				vim.cmd("Flog")
			end
			print("Menu Submitted: ", item.text)
		end,
	})
	function GitUi()
		git_menu:mount()
	end

	vim.api.nvim_create_user_command("Ui", function(opts)
		local arg = opts.args
		if arg == "git" then
			GitUi()
		end
	end, { nargs = 1, desc = "Open Git UI with an argument" })


	vim.api.nvim_create_user_command("Session", function(opts)
		require("persistence").select()
	end, {})

	-- 自定义命令：格式化
	vim.api.nvim_create_user_command("Format", function(opts)
		FileFmt(false) -- 格式化整个文件
	end, { desc = "格式化整个文件" })

	vim.api.nvim_create_user_command("FormatGit", function(opts)
		FileFmt(true) -- 只格式化 git 修改的部分
	end, { desc = "只格式化 git 修改的部分" })

	-- 快速打开帮助文档
	vim.api.nvim_create_user_command("MergeHelp", function()
		vim.cmd("e ~/.config/nvim/GIT_MERGE_GUIDE.md")
	end, { desc = "打开 Git Merge 工具使用指南" })

	vim.api.nvim_create_user_command("MergeQuick", function()
		vim.cmd("e ~/.config/nvim/MERGE_QUICK_REF.md")
	end, { desc = "打开 Git Merge 快速参考" })

	vim.keymap.set("n", "<leader>g?", "<cmd>MergeHelp<CR>", { desc = "Git Merge 帮助" })

	-- Git 分支切换后自动刷新
	-- 解决 LSP 跳转到旧分支代码的问题
	local function reload_all_buffers_and_lsp()
		-- 保存当前窗口和位置
		local current_win = vim.api.nvim_get_current_win()
		local current_buf = vim.api.nvim_get_current_buf()
		local cursor_pos = vim.api.nvim_win_get_cursor(current_win)

		-- 重新加载所有已打开的文件 buffer
		local buffers = vim.api.nvim_list_bufs()
		for _, buf in ipairs(buffers) do
			if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
				local bufname = vim.api.nvim_buf_get_name(buf)
				-- 只重新加载实际文件（不是特殊 buffer）
				if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
					-- 检查文件是否被修改
					if not vim.api.nvim_buf_get_option(buf, "modified") then
						vim.api.nvim_buf_call(buf, function()
							vim.cmd("checktime") -- 检查文件是否在外部被修改
							vim.cmd("edit") -- 重新加载
						end)
					end
				end
			end
		end

		-- 重启所有 LSP 客户端
		vim.schedule(function()
			-- 使用 LspRestart 命令重启所有 LSP
			vim.cmd("LspRestart")

			-- 等待 LSP 重启完成后恢复光标位置
			vim.defer_fn(function()
				pcall(function()
					vim.api.nvim_set_current_win(current_win)
					vim.api.nvim_win_set_cursor(current_win, cursor_pos)
				end)

				print("✅ 已刷新所有文件和 LSP")
			end, 500)
		end)
	end

	-- 获取文件所属的 git 仓库目录
	local function get_git_root(file_path)
		if not file_path or file_path == "" then
			return nil
		end

		-- 获取文件所在目录
		local dir = vim.fn.fnamemodify(file_path, ":h")
		
		-- 从文件所在目录向上查找 .git
		local git_dir = vim.fn.finddir(".git", dir .. ";")
		if git_dir ~= "" and git_dir ~= "." then
			-- 返回 git 仓库根目录（.git 的父目录）
			return vim.fn.fnamemodify(git_dir, ":h")
		end

		-- 尝试查找 .git 文件（submodule 或 worktree）
		local git_file = vim.fn.findfile(".git", dir .. ";")
		if git_file ~= "" then
			local content = vim.fn.readfile(git_file)
			if #content > 0 then
				local gitdir = content[1]:match("gitdir:%s*(.+)")
				if gitdir then
					return vim.fn.fnamemodify(git_file, ":h")
				end
			end
		end

		return nil
	end

	-- 监听多个 Git 仓库的 HEAD 变化
	-- local watched_repos = {}  -- 记录已监听的仓库 {git_root -> {timer, last_head}}
	
	-- local function watch_git_repo(git_root)
	-- 	-- 如果已经在监听这个仓库，跳过
	-- 	if watched_repos[git_root] then
	-- 		return
	-- 	end

	-- 	local git_dir = git_root .. "/.git"
	-- 	local head_file = git_dir .. "/HEAD"

	-- 	-- 检查 .git/HEAD 是否存在
	-- 	if vim.fn.filereadable(head_file) ~= 1 then
	-- 		-- 可能是 .git 文件（submodule）
	-- 		local git_file = git_root .. "/.git"
	-- 		if vim.fn.filereadable(git_file) == 1 then
	-- 			local content = vim.fn.readfile(git_file)
	-- 			if #content > 0 then
	-- 				local gitdir = content[1]:match("gitdir:%s*(.+)")
	-- 				if gitdir then
	-- 					-- 处理相对路径
	-- 					if not gitdir:match("^/") then
	-- 						gitdir = git_root .. "/" .. gitdir
	-- 					end
	-- 					head_file = gitdir .. "/HEAD"
	-- 				end
	-- 			end
	-- 		end
	-- 	end

	-- 	if vim.fn.filereadable(head_file) ~= 1 then
	-- 		return
	-- 	end

	-- 	-- 记录当前 HEAD 内容
	-- 	local last_head = vim.fn.readfile(head_file)

		-- 创建定时器，每秒检查一次
	-- 	local timer = vim.loop.new_timer()
	-- 	timer:start(
	-- 		1000,
	-- 		1000,
	-- 		vim.schedule_wrap(function()
	-- 			if vim.fn.filereadable(head_file) == 1 then
	-- 				local current_head = vim.fn.readfile(head_file)
	-- 				-- 如果 HEAD 变化了，说明切换了分支
	-- 				if vim.inspect(current_head) ~= vim.inspect(last_head) then
	-- 					last_head = current_head
	-- 					local branch = current_head[1]:match("ref: refs/heads/(.+)") or "HEAD"
	-- 					print(string.format("🔄 [%s] 检测到分支切换到 %s，正在刷新...", 
	-- 						vim.fn.fnamemodify(git_root, ":t"), branch))
	-- 					reload_all_buffers_and_lsp()
	-- 				end
	-- 			end
	-- 		end)
	-- 	)

	-- 	-- 保存监听信息
	-- 	watched_repos[git_root] = {
	-- 		timer = timer,
	-- 		last_head = last_head,
	-- 		head_file = head_file,
	-- 	}

	-- 	print(string.format("👁️  开始监听 git 仓库: %s", vim.fn.fnamemodify(git_root, ":t")))
	-- end

	-- -- 扫描所有已打开文件的 git 仓库并监听
	-- local function scan_and_watch_all_repos()
	-- 	local buffers = vim.api.nvim_list_bufs()
	-- 	local repos = {}

	-- 	for _, buf in ipairs(buffers) do
	-- 		if vim.api.nvim_buf_is_loaded(buf) then
	-- 			local bufname = vim.api.nvim_buf_get_name(buf)
	-- 			if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
	-- 				local git_root = get_git_root(bufname)
	-- 				if git_root and git_root ~= "" then
	-- 					repos[git_root] = true
	-- 				end
	-- 			end
	-- 		end
	-- 	end

	-- 	-- 为每个仓库创建监听
	-- 	for git_root, _ in pairs(repos) do
	-- 		watch_git_repo(git_root)
	-- 	end
	-- end

	-- -- 当打开新文件时，检查是否需要监听新的 git 仓库
	-- vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
	-- 	callback = function(args)
	-- 		local bufname = vim.api.nvim_buf_get_name(args.buf)
	-- 		if bufname ~= "" then
	-- 			local git_root = get_git_root(bufname)
	-- 			if git_root and git_root ~= "" then
	-- 				watch_git_repo(git_root)
	-- 			end
	-- 		end
	-- 	end,
	-- })

	-- -- 启动时扫描并监听所有仓库
	-- vim.defer_fn(scan_and_watch_all_repos, 1000)

	-- -- 手动刷新命令（当自动刷新不够用时）
	-- vim.api.nvim_create_user_command("ReloadGit", function()
	-- 	reload_all_buffers_and_lsp()
	-- end, { desc = "重新加载所有文件和 LSP（切换分支后使用）" })

	-- -- 查看当前监听的所有 git 仓库
	-- vim.api.nvim_create_user_command("GitWatchList", function()
	-- 	if vim.tbl_count(watched_repos) == 0 then
	-- 		print("⚠️  当前没有监听任何 git 仓库")
	-- 		print("💡 打开一些文件后会自动开始监听")
	-- 		return
	-- 	end

	-- 	print("📋 当前正在监听的 git 仓库：")
	-- 	print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	-- 	local idx = 1
	-- 	for git_root, info in pairs(watched_repos) do
	-- 		local branch = "unknown"
	-- 		if info.last_head and #info.last_head > 0 then
	-- 			branch = info.last_head[1]:match("ref: refs/heads/(.+)") or 
	-- 			         info.last_head[1]:sub(1, 8) -- 如果是 detached HEAD，显示 hash 前8位
	-- 		end
	-- 		print(string.format("%d. %s", idx, vim.fn.fnamemodify(git_root, ":t")))
	-- 		print(string.format("   路径: %s", git_root))
	-- 		print(string.format("   分支: %s", branch))
	-- 		print(string.format("   HEAD: %s", info.head_file))
	-- 		print("")
	-- 		idx = idx + 1
	-- 	end
	-- 	print(string.format("✅ 共监听 %d 个仓库", vim.tbl_count(watched_repos)))
	-- end, { desc = "查看当前监听的 git 仓库列表" })

	-- -- 强制重新扫描所有仓库
	-- vim.api.nvim_create_user_command("GitWatchRescan", function()
	-- 	print("🔄 重新扫描 git 仓库...")
	-- 	scan_and_watch_all_repos()
	-- end, { desc = "重新扫描并监听所有 git 仓库" })

	-- -- 快捷键：手动刷新
	-- vim.keymap.set("n", "<leader>gr", "<cmd>ReloadGit<CR>", { desc = "刷新文件和 LSP" })
	-- vim.keymap.set("n", "<leader>gw", "<cmd>GitWatchList<CR>", { desc = "查看监听的 git 仓库" })
end
