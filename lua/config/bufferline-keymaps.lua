local M = {}
M.setup = function(map, opt)
	map("n", "H", "<cmd>BufferLineCyclePrev<CR>", opt)
	map("n", "L", "<cmd>BufferLineCycleNext<CR>", opt)
	map("n", "x", "<cmd>bdelete!<CR>", opt)
	map("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", opt)
	map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", opt)
	map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opt)
end
return M
