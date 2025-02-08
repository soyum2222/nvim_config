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
						["ctrl-a"] = "toggle-all",
					},
				},
				actions = {
					files = {
						["ctrl-q"] = actions.file_sel_to_qf,
						["enter"] = actions.file_edit_or_qf,
					},
				},
			})
		end,
	},
}
