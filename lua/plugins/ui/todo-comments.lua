return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
	},
	keys = {
		---@diagnostic disable-next-line: undefined-field
		{
			"<leader>st",
			function()
				require("snacks").picker.todo_comments({
					keywords = { "TODO", "FIX", "FIXME", "BUG", "FIXIT", "HACK", "WARN", "ISSUE" },
				})
			end,
			desc = "[TODO] Pick todos (without NOTE)",
		},
		---@diagnostic disable-next-line: undefined-field
		{
			"<leader>sT",
			function()
				require("snacks").picker.todo_comments()
			end,
			desc = "[TODO] Pick todos (with NOTE)",
		},
	},
	config = true,
}
