return {

	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			git = {
				ignore = false,
			},
			filters = {
				git_ignored = false,
				dotfiles = false,
			},
		}
	end,

}
