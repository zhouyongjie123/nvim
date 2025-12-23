local M = {}

M.setup = function(map, opt)
	local default_opts = { desc = "Yanky mapping" }
	local map_opts = vim.tbl_deep_extend("force", default_opts, opt or {})
	map({ "n", "x" }, "p", "<Plug>(YankyPutIndentAfterLinewise)", map_opts)
	map({ "n", "x" }, "P", "<Plug>(YankyPutIndentBeforeLinewise)", map_opts)
	map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", map_opts)
	map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", map_opts)
end

return M
