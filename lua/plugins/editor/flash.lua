return {
	"folke/flash.nvim",
	event = "BufReadPost",
	opts = {
		label = {
			rainbow = {
				enabled = true,
				shade = 1,
			},
		},
		modes = {
			char = {
				enabled = false,
			},
		},
	},
	keys = {
		{
			"f",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "[Flash] Jump",
		},
		{
			"<leader>j",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					search = { mode = "search", max_length = 0 },
					label = { after = { 0, 0 }, matches = false },
					jump = { pos = "end" },
					pattern = "^\\s*\\S\\?", -- match non-whitespace at start plus any character (ignores empty lines)
				})
			end,
			desc = "[Flash] Line jump",
		},
		{
			"<leader>k",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					search = { mode = "search", max_length = 0 },
					label = { after = { 0, 0 }, matches = false },
					jump = { pos = "end" },
					pattern = "^\\s*\\S\\?", -- match non-whitespace at start plus any character (ignores empty lines)
				})
			end,
			desc = "[Flash] Line jump",
		},
	},
}
