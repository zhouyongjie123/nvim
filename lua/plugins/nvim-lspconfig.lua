return {
	-- LSP 核心
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"mfussenegger/nvim-jdtls",
	},
	opts = {
		servers = {
			jdtls = {},
		},
		setup = {
			jdtls = function()
				return true -- avoid duplicate servers
			end,
		},
	},
	config = function() end,
}
