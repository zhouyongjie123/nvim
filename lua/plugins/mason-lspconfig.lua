return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ui = {
			icons = {
				package_installed = "√",
				package_pending = "+",
				package_uninstalled = "x",
			},
		},
		ensure_installed = { "lua_ls", "rust_analyzer", "jdtls" },
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
