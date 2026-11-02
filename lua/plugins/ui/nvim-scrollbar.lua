return {
	"petertriho/nvim-scrollbar",
	init = function()
		vim.g.scrollbar_v2_notice = false
	end,
	opts = {
		handelers = {
			gitsigns = true, -- Requires gitsigns
			search = true, -- Requires hlslens
		},
		marks = {
			Search = {
				color = "#CBA6F7",
			},
			GitAdd = { text = "┃" },
			GitChange = { text = "┃" },
			GitDelete = { text = "_" },
		},
	},
}
