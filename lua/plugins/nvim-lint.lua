return {
	--"mfussenegger/nvim-lint",
	--config = function()
	--        require('lint').linters.golangcilint = {
	--                cmd = 'golangcilint',
	--                stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
	--                args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
	--                stream = nil, -- ('stdout' | 'stderr') configure the stream to which the linter outputs the linting result.
	--                parser = your_parse_function
	--        }
	--        require("lint").linters_by_ft = {
	--                markdown = { "vale" },
	--                go = { "golangcilint" },
	--        }

	--        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	--                callback = function()
	--                        -- try_lint without arguments runs the linters defined in `linters_by_ft`
	--                        -- for the current filetype
	--                        require("lint").try_lint()

	--                        -- You can call `try_lint` with a linter name or a list of names to always
	--                        -- run specific linters, independent of the `linters_by_ft` configuration
	--                        --require("lint").try_lint("cspell")
	--                end,
	--        })
	--end,
}
