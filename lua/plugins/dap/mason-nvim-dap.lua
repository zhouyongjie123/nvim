return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = "mason.nvim",
	cmd = { "DapInstall", "DapUninstall" },
	opts = {
		handlers = {},
		ensure_installed = {
			"delve", -- Go 调试适配器
		},
	},
	-- mason-nvim-dap is loaded when nvim-dap loads
	config = function() end,
}
