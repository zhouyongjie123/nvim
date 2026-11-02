return {
	"igorlfs/nvim-dap-view",
	dependencies = {
		{
			-- Solve the display issue with lualine
			"nvim-lualine/lualine.nvim",
			optional = true,
			opts = { options = { disabled_filetypes = { winbar = { "dap-view", "dap-view-term", "dap-repl" } } } },
		},
	},
    -- stylua: ignore
    keys = {
      { "<leader>Du", function() require("dap-view").toggle() end, desc = "[DAP view] Toggle dap-view" },
    },
	---@module 'dap-view'
	---@type dapview.Config
	opts = {
		winbar = {
			sections = { "scopes", "repl", "watches", "breakpoints", "exceptions" },
			default_section = "scopes",
			controls = {
				enabled = true,
			},
		},
		windows = {
			height = 0.25,
			position = "below",
			terminal = {
				width = 0.5,
				position = "right",
				start_hidden = false, -- 一起来就能看到程序 stdout
				-- List of debug adapters for which the terminal should be ALWAYS hidden
				hide = {},
			},
		},
		help = {
			border = "rounded",
		},
		auto_toggle = true, -- launch/attach 自动开面板，terminate/disconnect 自动关
	},
}
