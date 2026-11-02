return {
	"nvim-treesitter/nvim-treesitter",
	optional = true,
	opts = {
		ensure_installed = { "go" },
		highlight = {
			enable = true, -- 启用高亮
			additional_vim_regex_highlighting = false,
		},
	},
	opts_extend = { "ensure_installed" },
}
