return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets", -- 通用片段库（含少量 Dart/Flutter）
	},
	config = function()
		local luasnip = require("luasnip")
		luasnip.setup({
			history = true, -- 记住上次选择的片段
			updateevents = "TextChanged,TextChangedI", -- 实时更新片段
			enable_autosnippets = true, -- 启用自动触发片段
			ext_opts = {
				[require("luasnip.util.types").insertNode] = {
					active = { virt_text = { { "󰚩 可编辑", "Comment" } } },
				},
			},
		})
		-- 加载所有语言的自定义片段
		-- require("plugins.editor.snip.snippets")
		require("plugins.editor.snip.snippets")
	end,
}
