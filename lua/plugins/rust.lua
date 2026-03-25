return {
	-- Cargo.toml 依赖管理体验（版本提示/补全/更新等）
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local crates = require("crates")
			crates.setup({
				completion = {
					cmp = { enabled = true },
				},
			})

			-- 仅对 toml（尤其是 Cargo.toml）启用 crates 补全源
			local ok_cmp, cmp = pcall(require, "cmp")
			if ok_cmp then
				cmp.setup.filetype("toml", {
					sources = cmp.config.sources({
						{ name = "crates" },
						{ name = "path" },
						{ name = "buffer" },
					}),
				})
			end
		end,
	},
}
