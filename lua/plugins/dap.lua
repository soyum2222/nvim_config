return {

	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"Pocco81/DAPInstall.nvim",
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			function DapDebug()
				require("dap.ext.vscode").load_launchjs(nil, nil)
				local file_type = vim.bo.filetype
				if file_type == "go" then
					require("dap").continue()
				else
					require("dap").continue()
				end
			end

			require("dap-go").setup({
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						-- Must be "go" or it will be ignored by the plugin
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				-- delve configurations
				delve = {
					-- the path to the executable dlv which will be used for debugging.
					-- by default, this is the "dlv" executable on your PATH.
					path = "/Users/silver-be/go/bin/dlv",
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port.
					-- if you set a port in your debug configuration, its value will be
					-- assigned dynamically.
					port = "38697",
					-- additional args to pass to dlv
					args = {},
					-- the build flags that are passed to delve.
					-- defaults to empty string, but can be used to provide flags
					-- such as "-tags=unit" to make sure the test suite is
					-- compiled during debugging, for example.
					-- passing build flags using args is ineffective, as those are
					-- ignored by delve in dap mode.
					-- avaliable ui interactive function to prompt for arguments get_arguments
					build_flags = {},
					-- whether the dlv process to be created detached or not. there is
					-- an issue on delve versions < 1.24.0 for Windows where this needs to be
					-- set to false, otherwise the dlv server creation will fail.
					-- avaliable ui interactive function to prompt for build flags: get_build_flags
					detached = vim.fn.has("win32") == 0,
					-- the current working directory to run dlv from, if other than
					-- the current working directory.
					cwd = nil,
				},
				-- options related to running closest test
				tests = {
					-- enables verbosity when running the test.
					verbose = false,
				},
			})

			require("dap-python").setup("python")

			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "/opt/nvim-cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}

			require("dapui").setup()

			require("nvim-dap-virtual-text").setup({
				enabled = true, -- enable this plugin (the default)
				enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true, -- show stop reason when stopped for exceptions
				commented = false, -- prefix virtual text with comment string
				-- experimental features:
				virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
				-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
			})

			--local dap, dapui = require("dap"), require("dapui")
			--dap.listeners.before.attach.dapui_config = function()
			--        dapui.open()
			--end
			--dap.listeners.before.launch.dapui_config = function()
			--        dapui.open()
			--end
			--dap.listeners.before.event_terminated.dapui_config = function()
			--        dapui.close()
			--end
			--dap.listeners.before.event_exited.dapui_config = function()
			--        dapui.close()
			--end

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
				},
				{
					name = "Attach to gdbserver :1234",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/usr/bin/gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			}
		end,
	},
}
