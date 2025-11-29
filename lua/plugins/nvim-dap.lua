return {
	"mfussenegger/nvim-dap",
	recommended = true,
	optional = true,
	desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
	config = function()
		local dap = require("dap")
		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}
		dap.adapters.java = {
			type = "executable",
			command = "java-debug-adapter",
		}
		local Terminal = require("toggleterm.terminal").Terminal
		local dap_term = nil
		dap.defaults.fallback.terminal_win_cmd = function(config)
			if dap_term and dap_term:is_open() then
				return dap_term.bufnr, dap_term.window
			end
			dap_term = Terminal:new({
				direction = "horizontal",
				size = config.terminal_size or 15,
				close_on_exit = false,
				hidden = true,
				on_open = function(term)
					vim.api.nvim_set_option_value("modified", false, { buf = term.bufnr })
					vim.api.nvim_set_option_value("buftype", "terminal", { buf = term.bufnr })
					vim.api.nvim_set_option_value("modifiable", false, { buf = term.bufnr })
				end,
				on_close = function()
					dap_term = nil
				end,
			})

			dap_term:open()
			return dap_term.bufnr, dap_term.window
		end

		local icons = {
			dap = {
				Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
				Breakpoint = " ",
				BreakpointCondition = " ",
				BreakpointRejected = { " ", "DiagnosticError" },
				LogPoint = ".>",
			},
		}

		-- 配置 mason-nvim-dap
		if package.loaded["mason-nvim-dap"] then
			require("mason-nvim-dap").setup()
		end

		-- 设置断点行高亮
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		-- 配置调试图标
		for name, sign in pairs(icons.dap) do
			sign = type(sign) == "table" and sign or { sign }
			vim.fn.sign_define(
				"Dap" .. name,
				{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
			)
		end
	end,
	keys = {
		-- {
		-- 	"<leader>dB",
		-- 	function()
		-- 		require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		-- 	end,
		-- 	desc = "Breakpoint Condition",
		-- },
		{
			"<leader>dp",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Run/Continue",
		},
		{
			"<leader>da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to Line (No Execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dP",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
	},
	dependencies = {
		"rcarriga/nvim-dap-ui",
		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
		{
			"mason-org/mason.nvim",
			opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
		},
	},
}
