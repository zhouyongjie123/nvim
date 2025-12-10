return {
	"nvim-treesitter/nvim-treesitter",
	optional = true,
	opts = {
		ensure_installed = { "python" },
	},
	opts_extend = { "ensure_installed" },
}
