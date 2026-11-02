-- 与 <leader>rr 运行面板对齐：${fileDirname} 在子包里会变成一个没有 main 的包，
-- 真正能调试的是 go.mod 所在的模块根
local function module_root()
	local name = vim.api.nvim_buf_get_name(0)
	local path = name ~= "" and name or vim.fn.getcwd()
	local mod = vim.fs.find("go.mod", { upward = true, limit = 1, path = path })[1]
	return mod and vim.fs.dirname(mod) or vim.fn.getcwd()
end

local CONSOLE_ADAPTER = "dlv-panel"
local CONSOLE_CONFIG = "Debug (output in run panel)"

-- dlv 的 stdout 就是被调试程序的 stdout：让它跑在面板里，面板就成了 IDEA 的 Debug 控制台。
-- 端口交给系统分配（-l 127.0.0.1:0），从 dlv 打印的那行读回来，
-- 既不会和上次会话残留的 dlv 撞端口，也不能用“试连接”判断就绪：
-- 独立跑的 dlv dap 只接受一个客户端，探测连接会把 nvim-dap 的位置占掉。
local debug_port = 0

---@return integer? port
local function wait_listening(bufnr, timeout_ms)
	local port
	vim.wait(timeout_ms, function()
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return true
		end
		for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
			port = line:match("DAP server listening at:%s*[%d%.]+:(%d+)")
			if port then
				return true
			end
		end
		return false
	end, 100)
	return port and tonumber(port)
end

local function start_debug()
	local RunPanel = require("config.keymaps.go-run-keymaps")
	-- exec：让 dlv 顶掉 shell，关面板（SIGINT 到整个进程组）时 dlv 和程序一起走
	local term = RunPanel.run("exec dlv dap -l 127.0.0.1:0", "dlv dap 调试服务")
	if not term then
		return
	end
	local port = wait_listening(term.buf, 10000)
	if not port then
		vim.notify("dlv 调试服务 10 秒没起来，去运行面板看报错", vim.log.levels.ERROR)
		return
	end
	debug_port = port
	local dap = require("dap")
	for _, config in ipairs(dap.configurations.go or {}) do
		if config.name == CONSOLE_CONFIG then
			return dap.run(config)
		end
	end
	vim.notify("没有 Go 调试配置", vim.log.levels.WARN)
end

return {
	"mfussenegger/nvim-dap",
	optional = true,
	keys = {
		{ "<leader>rd", start_debug, desc = "Go: Debug（底部面板看程序输出）" },
	},
	opts = function()
		local dap = require("dap")

		-- dlv 收到 disconnect 就直接退出，来不及回 terminated，dap-view 的 auto_toggle 收不到信号。
		-- 面板里的 dlv 进程退出 = 这次调试结束，用它来收面板。
		vim.api.nvim_create_autocmd("TermClose", {
			group = vim.api.nvim_create_augroup("go_dap_panel", { clear = true }),
			callback = function(ev)
				if not vim.b[ev.buf].snacks_terminal then
					return
				end
				vim.defer_fn(function()
					if not dap.session() then
						pcall(function() require("dap-view").close() end)
					end
				end, 200)
			end,
		})

		dap.adapters[CONSOLE_ADAPTER] = function(callback)
			callback({ type = "server", host = "127.0.0.1", port = debug_port })
		end

		dap.adapters.delve = function(callback, config)
			if config.mode == "remote" then
				callback({
					type = "server",
					host = config.host or "127.0.0.1",
					port = config.port or 2345,
				})
			else
				callback({
					type = "server",
					host = "127.0.0.1",
					port = 2345,
					executable = {
						command = "dlv",
						args = { "dap", "-l", "127.0.0.1:2345" },
					},
				})
			end
		end

		dap.configurations.go = {
			{
				type = CONSOLE_ADAPTER,
				name = CONSOLE_CONFIG,
				request = "launch",
				program = module_root,
				mode = "debug",
			},
			{
				type = "delve",
				name = "Debug current file",
				request = "launch",
				program = module_root,
				mode = "debug",
			},
			{
				type = "delve",
				name = "Debug test (current file)",
				request = "launch",
				program = "${fileDirname}",
				mode = "test",
			},
			{
				type = "delve",
				name = "Debug test (nearest)",
				request = "launch",
				program = "${fileDirname}",
				mode = "test",
				args = function()
					local test_name = vim.fn.input("Test name (leave empty for all): ")
					if test_name == "" then
						return {}
					end
					return { "-test.run", test_name }
				end,
			},
			{
				type = "delve",
				name = "Attach to process",
				request = "attach",
				mode = "local",
				processId = function()
					return vim.fn.input("Process ID: ")
				end,
			},
			{
				type = "delve",
				name = "Connect to remote server",
				request = "attach",
				mode = "remote",
				host = "127.0.0.1",
				port = 2345,
			},
		}
	end,
}
