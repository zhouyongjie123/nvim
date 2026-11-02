return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",
	},
	opts = {
		adapters = {
			["neotest-go"] = {
				recursive_run = true,
				experimental = {
					test_table = true,
				},
			},
		},
		status = { virtual_text = true },
		output = { open_on_run = true },
		quickfix = { enabled = true },
	},
	config = function(_, opts)
		local neotest = require("neotest")
		neotest.setup(opts)
	end,
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "[Test] Run nearest",
		},
		{
			"<leader>tR",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "[Test] Run file",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "[Test] Stop",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run(vim.fn.getcwd())
			end,
			desc = "[Test] Run all",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "[Test] Output",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "[Test] Output panel",
		},
		{
			"<leader>tt",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "[Test] Summary",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "[Test] Debug nearest",
		},
		{
			"<leader>tD",
			function()
				require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
			end,
			desc = "[Test] Debug file",
		},
	},
}
