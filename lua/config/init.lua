require("config.keymaps.keymaps")
require("config.options")
require("config.highlights")
require("config.rainbow")

-- 启动时如果有错误，暂停并显示，按任意键继续
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local msgs = vim.fn.execute("messages")
		if msgs:find("Error") or msgs:find("error") then
			vim.cmd("redraw")
			vim.fn.getchar()
		end
	end,
})
