return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = "mason.nvim",
	cmd = { "DapInstall", "DapUninstall" },
	opts = {
		handlers = {},
		ensure_installed = {
			"java-debug-adapter", -- Java 调试适配器
			"java-test", -- Java 测试适配器（可选）
		},
	},
	-- mason-nvim-dap is loaded when nvim-dap loads
	config = function() end,
}
