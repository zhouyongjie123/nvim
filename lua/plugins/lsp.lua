return {
	-- LSP 核心
	"neovim/nvim-lspconfig",
	dependencies = {
		-- 自动补全对接 LSP
		"hrsh7th/cmp-nvim-lsp",
		-- 增强 jdtls 功能（调试、导入组织等）
		"mfussenegger/nvim-jdtls",
	},
	config = function()
		-- 后续 LSP 配置写在这里
	end,
}
