return {
	"petertriho/nvim-scrollbar",
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
