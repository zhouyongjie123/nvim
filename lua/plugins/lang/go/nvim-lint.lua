return {
	"mfussenegger/nvim-lint",
	optional = true,
	opts = {
		linters_by_ft = {
			go = { "golangci_lint" },
		},
	},
}
