return {
	{
		--"akinsho/bufferline.nvim",
		--version = "*",
		--dependencies = "nvim-tree/nvim-web-devicons",

		--config = function()
		--        require("bufferline").setup({

		--                options = {

		--                        close_command = function(n)
		--                                Snacks.bufdelete(n)
		--                        end,
		--                        -- stylua: ignore
		--                        right_mouse_command = function(n) Snacks.bufdelete(n) end,
		--                        diagnostics = "nvim_lsp",
		--                        diagnostics_indicator = function(count, level, diagnostics_dict, context)
		--                                local icon = level:match("error") and " " or " "
		--                                return " " .. icon .. count
		--                        end,
		--                        always_show_bufferline = false,

		--                        offsets = {
		--                                {
		--                                        filetype = "NvimTree",
		--                                        text_align = "left",
		--                                        separator = true,
		--                                },
		--                                {
		--                                        filetype = "snacks_layout_box",
		--                                },
		--                        },

		--                        config = function(_, opts)
		--                                require("bufferline").setup(opts)
		--                                -- Fix bufferline when restoring a session
		--                                vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
		--                                        callback = function()
		--                                                vim.schedule(function()
		--                                                        pcall(nvim_bufferline)
		--                                                end)
		--                                        end,
		--                                })
		--                        end,
		--                },
		--        })
		--end,
	},
}
