return {
	"williamboman/mason.nvim",
	optional = true,
	opts = {
		ensure_installed = {
			"lua-language-server",
			"stylua",
		},
	},
	opts_extend = { "ensure_installed" },
}
