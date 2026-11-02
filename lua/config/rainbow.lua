-- 彩虹括号配置。必须在插件注册之前（init.lua 阶段）写入 vim.g：
-- 插件只挂在一个 FileType 自动命令上，showkeys/noice 等弹窗在 VeryLazy 创建缓冲区时
-- 会先触发 FileType，那时如果配置还不存在就会直接 attach 到没有 parser 的缓冲区并报错。
-- 这里的值全部是字符串，避免 Lua 函数经过 vim.g 往返后丢失。
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
		vim = "rainbow-delimiters.strategy.local",
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	-- 自定义组名，插件不会碰它们（插件只会用 default=true 重写 RainbowDelimiter*），
	-- 颜色定义见 lua/config/highlights.lua，保证一定压过插件自带的 gruvbox 默认色
	highlight = {
		"RainbowDelimiter1",
		"RainbowDelimiter2",
		"RainbowDelimiter3",
		"RainbowDelimiter4",
		"RainbowDelimiter5",
		"RainbowDelimiter6",
		"RainbowDelimiter7",
	},
}
