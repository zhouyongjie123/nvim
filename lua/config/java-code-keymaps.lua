local M = {}
M.setup = function(client, bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	local opts = { buffer = bufnr, silent = true }
	local keymap = vim.keymap.set

	keymap("n", "<leader>jo", require("jdtls").organize_imports, opts)
	keymap("n", "<leader>iv", require("jdtls").extract_variable, opts)
	keymap("v", "<leader>iv", require("jdtls").extract_variable, opts)
	keymap("n", "<leader>ic", require("jdtls").extract_constant, opts)
	keymap("v", "<leader>ic", require("jdtls").extract_constant, opts)
	keymap("v", "<leader>im", require("jdtls").extract_method, opts)

	-- vim.keymap.set("n", "<leader>ca", function()
	-- 	vim.lsp.buf.code_action({
	-- 		context = {
	-- 			triggerKind = 1,
	-- 			only = { "source" }, -- 只显示源码操作
	-- 		},
	-- 		apply = true,
	-- 		menu = "code_action",
	-- 	})
	-- end, { buffer = bufnr, desc = "code_action" })
end

return M
