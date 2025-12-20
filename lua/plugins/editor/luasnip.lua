return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets", -- 通用片段库（含少量 Dart/Flutter）
	},
	config = function()
		require("luasnip").setup({
			history = true, -- 记住上次选择的片段
			updateevents = "TextChanged,TextChangedI", -- 实时更新片段
			enable_autosnippets = true, -- 启用自动触发片段
		})
	end,
}
