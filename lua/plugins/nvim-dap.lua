return {
	"mfussenegger/nvim-dap",
	optional = true,
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
		local Terminal = require("toggleterm.terminal").Terminal
		local dap_term = nil
		dap.defaults.fallback.terminal_win_cmd = function(config)
			if dap_term and dap_term:is_open() then
				return dap_term.bufnr, dap_term.window
			end
			dap_term = Terminal:new({
				direction = "float",
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
	end,
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
		},
	},
}
