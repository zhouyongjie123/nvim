local M = {}

M.setup = function(bufnr)
	-- 确保缓冲区有效（避免之前的 "Invalid buffer id" 报错）
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	local opts = { buffer = bufnr, silent = true }
	local keymap = vim.keymap.set

	-- ====================== jdtls 特有快捷键（Java 专属功能）======================
	-- 组织导入（自动排序/去重导入语句）
	keymap("n", "<leader>jo", require("jdtls").organize_imports, opts)
	-- 提取变量（normal 模式：光标在变量上；visual 模式：选中内容）
	keymap("n", "<leader>iv", require("jdtls").extract_variable, opts)
	keymap("v", "<leader>iv", require("jdtls").extract_variable, opts)
	-- 提取常量（同上）
	keymap("n", "<leader>ic", require("jdtls").extract_constant, opts)
	keymap("v", "<leader>ic", require("jdtls").extract_constant, opts)
	-- 提取方法（visual 模式选中代码块）
	keymap("v", "<leader>im", require("jdtls").extract_method, opts)
end

return M
