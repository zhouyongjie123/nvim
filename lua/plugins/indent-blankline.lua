return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	main = "ibl",
	-- opts = {
	-- 	-- 基础缩进线配置
	-- 	indent = {
	-- 		char = "│", -- 普通缩进线的字符
	-- 	},
	-- 	-- 上下文高亮配置（关键）
	-- 	scope = {
	-- 		enabled = false, -- 启用上下文标记
	-- 		show_start = false, -- 显示上下文起始线（就是你看到的大括号后的竖线）
	-- 		show_end = false, -- 可选：是否显示上下文结束线
	-- 		inject_scope = true,
	-- 		-- 可选：自定义上下文线的字符和高亮
	-- 		char = "│",
	-- 		highlight = "IndentBlanklineContextChar",
	-- 		priority = 2,
	-- 	},
	-- },

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
