return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")
		autopairs.setup({
			check_ts = true, -- 启用 Treesitter 语法检测（更精准）
			ts_config = {
				java = { "string", "comment" }, -- Java 中忽略字符串/注释内的配对
				lua = { "string", "comment" },
			},
			enable_check_bracket_line = false, -- 允许在括号内换行时自动对齐
			fast_wrap = {},
		})

		-- 与 nvim-cmp 联动（补全后自动闭合括号）
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
