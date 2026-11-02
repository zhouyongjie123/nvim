return {
	"mason-org/mason.nvim",
	optional = true,
	opts = {
		ensure_installed = {
			"gopls",
			"goimports",
			"golangci-lint",
		},
	},
	opts_extend = { "ensure_installed" },
}
