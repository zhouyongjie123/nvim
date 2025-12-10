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
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")

			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
		opts_extend = { "ensure_installed" },
	},
}
