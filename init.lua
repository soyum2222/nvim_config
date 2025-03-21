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
	vim.cmd([[noremap <C-s> :lua vim.lsp.buf.format({ async = true })<CR>]])
	vim.cmd([[imap <C-s> <cmd>lua FileFmt()<CR>]])

	vim.cmd([[noremap <C-r> :lua require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) <CR>]])
	vim.cmd(
		[[vmap <C-r> :lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) <CR> ]]
	)
	-- vim.cmd([[ nmap <leader><F6> <Plug>(coc-rename)]])
	--vim.cmd([[noremap <C-s> :lua require('conform').format() <cr>]])
	--vim.cmd([[noremap <C-s> :lua vim.lsp.buf.format({ async = true })<CR>]])
	--vim.cmd([[noremap <C-s> :lua vim.lsp.buf.format({ async = true })<CR>]])
	vim.cmd([[imap <C-s> <cmd>lua FileFmt()<CR>]])
	vim.cmd([[noremap <C-s> <cmd>lua FileFmt()<CR>]])

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

	function FileFmt()
		-- for conform
		require("conform").format({
			async = true,
			lsp_fallback = true,
		}, function()
			print("Formatting completed!")
		end)

		-- for lspconfig
		--vim.lsp.buf.format({ async = true })

		-- for coc.nvim
		--local file_type = vim.bo.filetype
		--if file_type == "go" then
		--        require("go.format").goimports()
		--        return
		--end

		--vim.api.nvim_exec([[call CocActionAsync('format')]], true)

		--vim.api.nvim_exec([[update]], true)
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

	function FileFmt()
		local file_type = vim.bo.filetype
		if file_type == "go" then
			require("go.format").goimports()
			return
		end

		vim.lsp.buf.format({ async = true })
		--vim.api.nvim_exec([[call CocActionAsync('format')]], true)
		--vim.api.nvim_exec([[update]], true)
	end

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
end
