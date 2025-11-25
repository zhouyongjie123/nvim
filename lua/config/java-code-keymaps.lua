local M = {}
M.setup = function(client, bufnr)
	-- 确保缓冲区有效（避免之前的 "Invalid buffer id" 报错）
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	local opts = { buffer = bufnr, silent = true }
	local keymap = vim.keymap.set

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

	vim.keymap.set("n", "<leader>ca", function()
		-- 触发 LSP code action，指定使用浮窗菜单
		vim.lsp.buf.code_action({
			context = {
				triggerKind = 1, -- 手动触发
				only = { "source" }, -- 只显示源码操作（如优化导入、重构等）
			},
			apply = true,
			menu = "code_action",
		})
	end, { buffer = bufnr, desc = "code_action" })

	local toggleterm = require("toggleterm.terminal").Terminal
	local function run_java_file()
		local filetype = vim.bo.filetype
		if filetype ~= "java" then
			vim.notify("当前不是 Java 文件！", vim.log.levels.ERROR)
			return
		end

		local filepath = vim.fn.expand("%:p") -- 完整文件路径
		local filename = vim.fn.expand("%:t") -- 文件名
		local classname = vim.fn.expand("%:t:r") -- 类名
		local workdir = vim.fn.expand("%:p:h") -- 工作目录

		local compile_cmd = string.format("cd %s && javac -encoding UTF-8 %s", workdir, filename)

		vim.fn.jobstart(compile_cmd, {
			stdout_buffered = true,
			stderr_buffered = true,
			on_exit = function(_, exit_code, _)
				if exit_code ~= 0 then
					vim.notify("编译失败！", vim.log.levels.ERROR)
					return
				end

				local run_cmd = string.format("cd %s && java %s", workdir, classname)
				local term = toggleterm:new({ cmd = run_cmd, close_on_exit = false })
				term:toggle()
				-- 终端自动进入插入模式，方便直接操作
				vim.cmd("startinsert")
			end,
		})
	end

	local function stop_java_processes()
		vim.fn.jobstart("pkill -f java", {
			on_exit = function()
				vim.notify("已停止所有 Java 进程", vim.log.levels.INFO)
			end,
		})
	end
	vim.api.nvim_create_user_command("RunJava", run_java_file, {})
	vim.api.nvim_create_user_command("StopJava", stop_java_processes, {})
end

return M
