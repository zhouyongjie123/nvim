local M = {}

M.setup = function(map, opt)
	local default_opts = { desc = "Yanky mapping" }
	local map_opts = vim.tbl_deep_extend("force", default_opts, opt or {})
	-- map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", map_opts)
	-- map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", map_opts)
	map({ "n", "x" }, "p", "<Plug>(YankyPutIndentAfterLinewise)", map_opts)
	map({ "n", "x" }, "P", "<Plug>(YankyPutIndentBeforeLinewise)", map_opts)
	map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", map_opts)
	map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", map_opts)
	-- map({ "n" }, "<C-e>", "<Plug>(YankyPreviousEntry)", map_opts)
	-- map({ "n" }, "<C-r>", "<Plug>(YankyNextEntry)", map_opts)

	-- map("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", map_opts)
	-- map("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", map_opts)
	-- map("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", map_opts)
	-- map("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", map_opts)
	-- map("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)", map_opts)
	-- map("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)", map_opts)
	-- map("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", map_opts)
	-- map("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", map_opts)
	-- map("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", map_opts)
	-- map("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", map_opts)
	-- map("n", "=p", "<Plug>(YankyPutAfterFilter)", map_opts)
	-- map("n", "=P", "<Plug>(YankyPutBeforeFilter)", map_opts)
end

return M
