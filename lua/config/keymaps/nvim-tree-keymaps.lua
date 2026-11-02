local M = {}
M.nvimTreeList = {
	{
		key = { "<CR>", "o", "<2-LeftMouse>" },
		action = "edit",
	},
	{ key = "v", action = "vsplit" },
	{ key = "h", action = "split" },
	{ key = "i", action = "toggle_custom" },
	{ key = ".", action = "toggle_dotfiles" },
	{ key = "<F5>", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "s", action = "system_open" },
}
M.setup = function(map, opt)
	-- <leader>e: 树未打开 -> 打开并聚焦；已打开但焦点在别处 -> 聚焦；焦点已在树上 -> 收起
	map("n", "<leader>e", function()
		local tree = require("nvim-tree.api").tree
		if not tree.is_visible() then
			tree.open()
			return
		end
		if vim.api.nvim_get_current_win() == tree.winid() then
			tree.close()
		else
			tree.focus()
		end
	end, { desc = "Explorer", silent = true })

	-- 树里按 <Esc> 只把焦点送回编辑区，目录树保持打开
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "NvimTree",
		callback = function(ev)
			local function is_tree(win)
				return vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NvimTree"
			end
			vim.keymap.set("n", "<Esc>", function()
				local cur = vim.api.nvim_get_current_win()
				local alt = vim.fn.win_getid(vim.fn.winnr("#"))
				if alt ~= cur and vim.api.nvim_win_is_valid(alt) and not is_tree(alt) then
					vim.api.nvim_set_current_win(alt)
					return
				end
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					if win ~= cur and not is_tree(win) then
						vim.api.nvim_set_current_win(win)
						return
					end
				end
			end, { buffer = ev.buf, desc = "回编辑区（目录树不关闭）", silent = true })
		end,
	})
end
return M
