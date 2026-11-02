-- 自定义语法高亮颜色（在 colorscheme 加载后生效）
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local set_hl = vim.api.nvim_set_hl

		-- 函数/方法名 → 浅蓝色
		set_hl(0, "@function", { link = "Function", default = true })
		set_hl(0, "@function.call", { link = "@function", default = true })
		set_hl(0, "@method", { link = "@function", default = true })
		set_hl(0, "@method.call", { link = "@method", default = true })
		set_hl(0, "Function", { fg = "#82aaff" })

		-- 变量 → 统一浅白色
		set_hl(0, "@variable", { fg = "#eeffff" })
		set_hl(0, "@variable.builtin", { fg = "#f07178", italic = true })
		set_hl(0, "@parameter", { link = "@variable", default = true })

		-- 类型 → 黄色
		set_hl(0, "@type", { fg = "#ffcb6b" })
		set_hl(0, "@type.builtin", { fg = "#ffcb6b" })

		-- 包名（类型位置的 package_identifier）→ 青绿
		set_hl(0, "@module", { fg = "#80cbc4" })

		-- 字段/属性 → 浅橙色
		set_hl(0, "@field", { fg = "#f78c6c" })
		set_hl(0, "@property", { link = "@field", default = true })

		-- 常量 → 紫色
		set_hl(0, "@constant", { fg = "#c792ea" })
		set_hl(0, "@constant.builtin", { fg = "#c792ea", default = true })

		-- 关键字 → 红色/粉色
		set_hl(0, "@keyword", { fg = "#c792ea" })
		set_hl(0, "Keyword", { fg = "#c792ea" })

		-- 字符串 → 绿色
		set_hl(0, "@string", { fg = "#c3e88d" })

		-- 数字 → 橙色
		set_hl(0, "@number", { fg = "#f78c6c" })

		-- 运算符 → 浅蓝色
		set_hl(0, "@operator", { fg = "#89ddff" })

		-- 注释 → 灰色斜体
		set_hl(0, "@comment", { fg = "#546e7a", italic = true })

		-- 光标所在符号及其引用处：palenight 把这组写成 bold+italic+undercurl 并强行改成黄字，
		-- 这里只留底色块。nvim_set_hl 是整条定义替换，所以没写的属性（斜体/下划线/前景色）都会被清掉，
		-- 前景色因此仍然来自语法高亮本身。
		set_hl(0, "LspReferenceText", { bg = "#44425f" })
		set_hl(0, "LspReferenceRead", { bg = "#44425f" })
		set_hl(0, "LspReferenceWrite", { bg = "#545287" })

		-- 彩虹括号：组名由我们在 lua/config/rainbow.lua 里指定，插件不会覆盖，
		-- 因此这里设的颜色一定是最终渲染色（palenight 调色板，相邻层级对比最大化）
		set_hl(0, "RainbowDelimiter1", { fg = "#f07178" })
		set_hl(0, "RainbowDelimiter2", { fg = "#ffcb6b" })
		set_hl(0, "RainbowDelimiter3", { fg = "#82aaff" })
		set_hl(0, "RainbowDelimiter4", { fg = "#f78c6c" })
		set_hl(0, "RainbowDelimiter5", { fg = "#c3e88d" })
		set_hl(0, "RainbowDelimiter6", { fg = "#c792ea" })
		set_hl(0, "RainbowDelimiter7", { fg = "#89ddff" })
	end,
})
