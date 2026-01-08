return {
	"nvim-treesitter/nvim-treesitter",
	optional = true,
	opts = {
		ensure_installed = { "python", "ninja", "rst" },
	},
	opts_extend = { "ensure_installed" },
}
