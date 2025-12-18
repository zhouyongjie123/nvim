return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"igorlfs/nvim-dap-view",
		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
		{
			"mason-org/mason.nvim",
			opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
		},
		"jay-babu/mason-nvim-dap.nvim", -- 确保有这个依赖
	},
	opts = function()
		-- local dap = require("dap")
		-- dap.configurations.java = {
		-- 	{
		-- 		type = "java",
		-- 		request = "attach",
		-- 		name = "Debug (Attach) - Remote",
		-- 		hostName = "127.0.0.1",
		-- 		port = 5005,
		-- 	},
		-- }

        --stylua: ignore
        local dap_breakpoint = {
          breakpoint = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }, -- Nerd font: nf-cod-activate_breakpoints
          condition  = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
          rejected   = { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
          logpoint   = { text = "", texthl = "DapLogPoint",   linehl = "DapLogPoint",   numhl = "DapLogPoint"   },
          stopped    = { text = "", texthl = "DapStopped",    linehl = "DapStopped",    numhl = "DapStopped"    },
        }
		vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
		vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
		vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
		vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
		vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
	end,
	config = function()
		-- require("mason-nvim-dap").setup({
		-- 	automatic_installation = true,
		-- 	handlers = {},
		-- 	ensure_installed = {
		-- 		"java-debug-adapter", -- Java 调试适配器
		-- 		"java-test", -- Java 测试适配器（可选）
		-- 	},
		-- })
		-- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
		--
		-- local icons = {
		-- 	dap = {
		-- 		Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
		-- 		Breakpoint = " ",
		-- 		BreakpointCondition = " ",
		-- 		BreakpointRejected = { " ", "DiagnosticError" },
		-- 		LogPoint = ".>",
		-- 	},
		-- }
		-- for name, sign in pairs(icons.dap) do
		-- 	sign = type(sign) == "table" and sign or { sign }
		-- 	vim.fn.sign_define(
		-- 		"Dap" .. name,
		-- 		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
		-- 	)
		-- end
		local dap = require("dap")
		dap.defaults.fallback.external_terminal = {
			command = "/usr/bin/open", -- macOS 内置的 open 命令
			args = { "-a", "iTerm2" }, -- 参数：打开 iTerm2 应用
		}
	end,
    -- stylua: ignore
    keys = {
      { "<leader>ru",       function() require("dap").continue() end,                                                        mode = "n",          desc = "[DAP] Continue" },
      { "<F6>",       function() require("dap").step_over() end,                                                       mode = "n",          desc = "[DAP] Step over" },
      { "<F7>",       function() require("dap").step_into() end,                                                       mode = "n",          desc = "[DAP] Step into" },
      { "<F8>",       function() require("dap").step_out() end,                                                        mode = "n",          desc = "[DAP] Step out" },
      { "<F9>",       function() require("dap").pause() end,                                                           mode = "n",          desc = "[DAP] Pause" },
      { "<F10>",      function() require("dap").terminate() end,                                                       mode = "n",          desc = "[DAP] Terminate" },
      { "<Leader>dp",  function() require("dap").toggle_breakpoint() end,                                               mode = "n",          desc = "[DAP] Toggle breakpoint" },
      -- { "<Leader>B",  function() require("dap").set_breakpoint() end,                                                  mode = "n",          desc = "[DAP] Set breakpoint" },
      -- Remove the <leader>D binding in "x" mode
      { "<Leader>D" , mode = "x" },
      { "<Leader>Dr", function() require("dap").repl.open() end,                                                       mode = "n",          desc = "[DAP] Repl open" },
      { "<Leader>Dl", function() require("dap").run_last() end,                                                        mode = "n",          desc = "[DAP] Run last" },
      { "<Leader>Dd", function() require("dap.ui.widgets").hover() end,                                                mode = { "n", "v" }, desc = "[DAP] Widgets hover" },
      { "<Leader>Dp", function() require("dap.ui.widgets").preview() end,                                              mode = { "n", "v" }, desc = "[DAP] Widgets preview" },
      { "<Leader>Df", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.frames) end, mode = {"n"},        desc = "[DAP] Float frames" },
      { "<Leader>Ds", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.scopes) end, mode = {"n"},        desc = "[DAP] Float scopes" },
    },
}
