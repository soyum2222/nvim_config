return {
	{
		"folke/tokyonight.nvim",

		config = function()
			-- vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	{
		"Mofiqul/vscode.nvim",

		config = function()
			-- Lua:
			-- For dark theme (neovim's default)
			vim.o.background = "dark"
			-- For light theme
			--vim.o.background = "light"

			local c = require("vscode.colors").get_colors()

			require("vscode").setup({

				-- Alternatively set style in setup
				-- style = 'light'

				-- Enable transparent background
				transparent = true,

				-- Enable italic comment
				italic_comments = true,

				-- Underline `@markup.link.*` variants
				underline_links = true,

				-- Disable nvim-tree background color
				disable_nvimtree_bg = true,

				-- Override colors (see ./lua/vscode/colors.lua)
				color_overrides = {
					vscLineNumber = "#FFFFFF",
				},

				-- Override highlight groups (see ./lua/vscode/theme.lua)

				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
				},
			})
			-- require('vscode').load()

			-- load the theme without affecting devicon colors.

			-- vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"morhetz/gruvbox",
		config = function()
			--vim.cmd.colorscheme("gruvbox")
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			-- Lua
			require("onedark").setup({
				-- Main options --
				style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = false, -- Show/hide background
				term_colors = true, -- Change terminal color as per the selected theme style
				ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
				cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

				-- toggle theme style ---
				toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
				toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

				-- Change code style ---
				-- Options are italic, bold, underline, none
				-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},

				-- Lualine options --
				lualine = {
					transparent = false, -- lualine center bar transparency
				},

				-- Custom Highlights --
				colors = {}, -- Override default colors
				highlights = {}, -- Override highlight groups

				-- Plugins Config --
				diagnostics = {
					darker = true, -- darker colors for diagnostic
					undercurl = true, -- use undercurl instead of underline for diagnostics
					background = true, -- use background color for virtual text
				},
			})

			require("onedark").load()
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "Frappe", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				highlight_overrides = {
					all = function(colors)
						return {
							CurSearch = { bg = colors.sky },
							IncSearch = { bg = colors.sky },
							CursorLineNr = { fg = colors.blue, style = { "bold" } },
							DashboardFooter = { fg = colors.overlay0 },
							TreesitterContextBottom = { style = {} },
							WinSeparator = { fg = colors.overlay0, style = { "bold" } },
							["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
							["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
							Headline = { style = { "bold" } },
							Headline1 = { fg = colors.blue, style = { "bold" } },
							Headline2 = { fg = colors.pink, style = { "bold" } },
							Headline3 = { fg = colors.lavender, style = { "bold" } },
							Headline4 = { fg = colors.green, style = { "bold" } },
							Headline5 = { fg = colors.peach, style = { "bold" } },
							Headline6 = { fg = colors.flamingo, style = { "bold" } },
							rainbow1 = { fg = colors.blue, style = { "bold" } },
							rainbow2 = { fg = colors.pink, style = { "bold" } },
							rainbow3 = { fg = colors.lavender, style = { "bold" } },
							rainbow4 = { fg = colors.green, style = { "bold" } },
							rainbow5 = { fg = colors.peach, style = { "bold" } },
							rainbow6 = { fg = colors.flamingo, style = { "bold" } },
						}
					end,
				},
				color_overrides = {
					macchiato = {
						rosewater = "#F5B8AB",
						flamingo = "#F29D9D",
						pink = "#AD6FF7",
						mauve = "#FF8F40",
						red = "#E66767",
						maroon = "#EB788B",
						peach = "#FAB770",
						yellow = "#FACA64",
						green = "#70CF67",
						teal = "#4CD4BD",
						sky = "#61BDFF",
						sapphire = "#4BA8FA",
						blue = "#00BFFF",
						lavender = "#00BBCC",
						text = "#C1C9E6",
						subtext1 = "#A3AAC2",
						subtext0 = "#8E94AB",
						overlay2 = "#7D8296",
						overlay1 = "#676B80",
						overlay0 = "#464957",
						surface2 = "#3A3D4A",
						surface1 = "#2F313D",
						surface0 = "#1D1E29",
						base = "#0b0b12",
						mantle = "#11111a",
						crust = "#191926",
					},
				},

				custom_highlights = {},
				default_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					telescope = {
						enabled = true,
						style = "nvchad",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			-- setup must be called before loading
			--vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
}
