return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	config = function()
		require("Comment").setup({
			-- 新增：关闭自动注释延续（关键）
			ignore = "^$", -- 仅忽略空行的注释延续（可选，更精准）
			-- 或直接禁用所有自动延续（推荐，彻底解决）
			toggler = { line = "gcc", block = "gbc" },
			opleader = { line = "gc", block = "gb" },
			extra = { above = "gcO", below = "gco", eol = "gcA" },
			-- 禁用自动注释延续的核心配置
			pre_hook = nil,
			post_hook = nil,
			-- 关键：关闭 "自动延续注释" 功能
			mappings = {
				basic = true,
				extra = true,
				extended = false, -- 禁用扩展映射（避免误触发）
			},
		})
	end,
}
