return {
	"stevearc/conform.nvim",
	optional = true,
	opts = {
		formatters_by_ft = {
			dart = { "dart_format" },
		},
		format_on_save = {
			enable = true,
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
