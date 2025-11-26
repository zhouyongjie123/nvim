return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "√",
					package_pending = "+",
					package_uninstalled = "x",
				},
			},
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"jdtls",
				"clangd",
				"vue_ls",
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"java-debug-adapter",
				"java-test",
				"markdownlint-cli2",
				"markdown-toc",
			},
		},
	},
}
