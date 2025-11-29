return {
	"mfussenegger/nvim-dap",
	recommended = true,
	optional = true,
	desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
	opts = function()
		local dap = require("dap")
		dap.configurations.java = {
			-- {
			-- 	type = "java",
			-- 	request = "attach",
			-- 	name = "Debug (Attach) - Remote",
			-- 	hostName = "127.0.0.1",
			-- 	port = 5005,
			-- },
		}
		-- 不要添加下面这个配置,会报错
		-- dap.adapters.java = {
		-- 	type = "executable",
		-- 	command = "java",
		-- 	args = {
		-- 		"-jar",
		-- 		vim.fn.glob(
		-- 			"~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
		-- 		),
		-- 	},
		-- }
	end,
	config = function()
		-- local Terminal = require("toggleterm.terminal").Terminal
		-- local dap_term = nil
		-- local dap = require("dap")
		-- dap.defaults.fallback.terminal_win_cmd = function(config)
		-- 	-- if dap_term and dap_term:is_open() then
		-- 	-- 	return dap_term.bufnr, dap_term.window
		-- 	-- end
		-- 	-- 检查现有终端是否有效
		-- 	if dap_term and dap_term:is_open() then
		-- 		if vim.api.nvim_win_is_valid(dap_term.window) then
		-- 			return dap_term.bufnr, dap_term.window
		-- 		else
		-- 			dap_term.window = nil -- 重置无效窗口
		-- 		end
		-- 	end
		-- 	dap_term = Terminal:new({
		-- 		direction = "horizontal",
		-- 		-- size = config.terminal_size or 15,
		-- 		size = 15,
		-- 		close_on_exit = false,
		-- 		hidden = false,
		-- 		on_open = function(term)
		-- 			vim.api.nvim_set_option_value("modified", false, { buf = term.bufnr })
		-- 		end,
		-- 	})
		--
		-- 	dap_term:toggle()
		-- 	return dap_term.bufnr, dap_term.window
		-- end

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"java-debug-adapter", -- Java 调试适配器
				"java-test", -- Java 测试适配器（可选）
			},
		})
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		local icons = {
			dap = {
				Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
				Breakpoint = " ",
				BreakpointCondition = " ",
				BreakpointRejected = { " ", "DiagnosticError" },
				LogPoint = ".>",
			},
		}
		for name, sign in pairs(icons.dap) do
			sign = type(sign) == "table" and sign or { sign }
			vim.fn.sign_define(
				"Dap" .. name,
				{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
			)
		end
	end,
	keys = {
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
		-- {
		-- 	"<leader>da",
		-- 	function()
		-- 		require("dap").continue({ before = get_args })
		-- 	end,
		-- 	desc = "Run with Args",
		-- },
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
		"jay-babu/mason-nvim-dap.nvim", -- 确保有这个依赖
	},
}
