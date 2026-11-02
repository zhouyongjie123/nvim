return {
	"HiPhish/rainbow-delimiters.nvim",
	-- 插件只在 FileType 时挂载，必须赶在缓冲区打开前加载，否则启动时已打开的文件没有彩虹括号
	-- 参数见 lua/config/rainbow.lua
	lazy = false,
	config = function()
		-- NVIM 0.12 上 vim.treesitter.get_parser 对没有 parser 的缓冲区返回 nil（旧版本会报错），
		-- 插件在 lib.lua 里直接 index 它，弹窗缓冲区（showkeys/noice/nui）触发 FileType 时就会崩。
		-- 这里先确认 parser 存在再让插件 attach。
		local lib = require("rainbow-delimiters.lib")
		local attach = lib.attach
		lib.attach = function(bufnr)
			if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "" then
				return
			end
			local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
			if not lang or vim.api.nvim_buf_get_name(bufnr) == "" then
				return
			end
			local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
			if not ok or not parser then
				return
			end
			return attach(bufnr)
		end
	end,
}
