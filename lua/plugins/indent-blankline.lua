return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	main = "ibl",

	opts = function()
		Snacks.toggle({
			name = "Indention Guides",
			get = function()
				return require("ibl.config").get_config(0).enabled
			end,
			set = function(state)
				require("ibl").setup_buffer(0, { enabled = state })
			end,
		}):map("<leader>ug")

		return {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
			},
			exclude = {
				filetypes = {
					"Trouble",
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"notify",
					"snacks_dashboard",
					"snacks_notif",
					"snacks_terminal",
					"snacks_win",
					"toggleterm",
					"trouble",
				},
			},
		}
	end,

	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}
		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		vim.g.rainbow_delimiters = { highlight = highlight }
		require("ibl").setup({ scope = { highlight = highlight } })

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
