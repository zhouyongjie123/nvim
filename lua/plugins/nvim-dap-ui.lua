return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "x"} },
      },
		opts = {
			expand_lines = true, -- 自动展开变量
			floating = {
				border = "rounded", -- 浮动窗口边框（rounded/single/double/shadow）
				mappings = { close = { "q", "<Esc>" } },
			},
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 }, -- 变量作用域
						{ id = "breakpoints", size = 0.25 }, -- 断点列表
						{ id = "stacks", size = 0.25 }, -- 调用栈
						{ id = "watches", size = 0.25 }, -- 监视表达式
					},
					size = 40, -- 侧边栏宽度（字符数）
					position = "left", -- 位置（left/right）
				},
				{
					elements = {
						{ id = "repl", size = 0.5 }, -- REPL 终端
						{ id = "console", size = 0.5 }, -- 调试控制台
					},
					size = 10, -- 底部面板高度（行数）
					position = "bottom",
				},
			},
			windows = { indent = 1 }, -- 窗口缩进
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{ "nvim-neotest/nvim-nio" },
}
