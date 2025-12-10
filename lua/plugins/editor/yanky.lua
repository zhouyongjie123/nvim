return {
	"gbprod/yanky.nvim",
	-- recommended = true,
	desc = "Better Yank/Paste",
	dependencies = { "folke/snacks.nvim" },
	-- event = "VeryLazy",
	opts = function()
		local yanky = require("yanky")
		yanky.setup({
			system_clipboard = {
				sync_with_ring = not vim.env.SSH_CONNECTION,
			},
			highlight = { timer = 150 },
			picker = {
				select = {
					action = nil, -- nil to use default put action
				},
			},
		})
	end,
	keys = {
		{
			"<leader>p",
			function()
				Snacks.picker.yanky()
			end,
			mode = { "n", "x" },
			desc = "Open Yank History",
		},
	},
}
