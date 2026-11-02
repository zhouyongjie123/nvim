local M = {}
M.setup = function(map, opt)
	map("n", "H", "<cmd>BufferLineCyclePrev<CR>", opt)
	map("n", "L", "<cmd>BufferLineCycleNext<CR>", opt)
	map("n", "x", function()
		local cur_buf = vim.api.nvim_get_current_buf()

		local other_bufs = vim.tbl_filter(function(b)
			return b ~= cur_buf and vim.bo[b].buflisted
		end, vim.api.nvim_list_bufs())

		if #other_bufs > 0 then
			Snacks.bufdelete(cur_buf)
			vim.schedule(function()
				local ft = vim.bo[vim.api.nvim_get_current_buf()].filetype
				if ft == "NvimTree" or ft == "nvim-tree" then
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						local wft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
						if wft ~= "NvimTree" and wft ~= "nvim-tree" then
							vim.api.nvim_set_current_win(win)
							return
						end
					end
				end
			end)
		else
			-- 最后一个 buffer，关闭编辑区窗口，不留 [no name]
			local wins = vim.api.nvim_tabpage_list_wins(0)
			local editor_wins = vim.tbl_filter(function(w)
				local ft = vim.bo[vim.api.nvim_win_get_buf(w)].filetype
				return ft ~= "NvimTree" and ft ~= "nvim-tree"
			end, wins)
			if #editor_wins > 1 then
				vim.api.nvim_win_close(editor_wins[1], true)
			elseif #wins > 1 then
				vim.api.nvim_win_close(editor_wins[1], true)
			end
		end
	end, opt)
	map("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", opt)
	map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", opt)
	map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opt)
end
return M
