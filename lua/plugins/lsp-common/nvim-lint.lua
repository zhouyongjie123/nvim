return {
	"mfussenegger/nvim-lint",
	dependencies = {
		{
			"williamboman/mason.nvim",
			optional = true,
			opts = {
				-- ensure_installed = {
				-- 	"codespell",
				-- },
			},
			opts_extend = { "ensure_installed" },
		},
	},
	event = "BufWritePost",
	config = function()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				--           -- for the current filetype
				require("lint").try_lint()

				-- You can call `try_lint` with a linter name or a list of names to always
				-- run specific linters, independent of the `linters_by_ft` configuration
				require("lint").try_lint("codespell")
			end,
		})
	end,
}
