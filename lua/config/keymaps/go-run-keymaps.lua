local M = {}

-- IDEA 风格的“运行”面板：底部固定窗口，一次跑一个任务。
-- 重跑会先关掉上一个（连带杀掉进程），进程退出后面板和日志都留着，慢慢翻。
-- 位置/尺寸必须写在 win 里，且 split 读的是 win.height（不是 size）；
-- 用户 snacks.lua 的 styles.terminal 是 float，不覆盖就会弹成大浮窗。
local PANEL_ID = 90
local PANEL_HEIGHT = 14

local SnacksTerminal = require("snacks.terminal")

-- go.mod 所在目录才是模块根，go run/build/test 必须在它下面执行
local function go_root()
	local name = vim.api.nvim_buf_get_name(0)
	local path = name ~= "" and name or vim.fn.getcwd()
	local mod = vim.fs.find("go.mod", { upward = true, limit = 1, path = path })[1]
	return mod and vim.fs.dirname(mod) or vim.fn.getcwd()
end

---@return snacks.win? 面板（没有则 nil）
local function panel()
	for _, t in ipairs(SnacksTerminal.list()) do
		local info = vim.b[t.buf].snacks_terminal
		if info and info.id == PANEL_ID then
			return t
		end
	end
end

-- 先 Ctrl-C 再关窗口：t:close() 只 kill 作业本身（用 exec 时就是 dlv），
-- 它 ptrace 拉起的程序会变成孤儿继续占着端口；SIGINT 打整个 pty 前台进程组，一起收。
local function close_panel()
	local t = panel()
	if not t then
		return
	end
	local job = vim.b[t.buf].terminal_job_id
	if job and vim.fn.jobwait({ job }, 0)[1] == -1 then
		vim.api.nvim_chan_send(job, "\003")
		vim.fn.jobwait({ job }, 1000)
	end
	t:close()
end

-- POSIX 单引号转义，命令行里带引号也不会把 echo 拼坏
local function sh_quote(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

local function run(cmd, label, cwd_override)
	close_panel()
	-- 像 IDEA 那样，控制台第一行是先运行的命令
	local script = "echo " .. sh_quote("> " .. (label or cmd)) .. "; " .. cmd
	local term = SnacksTerminal.open({ vim.o.shell, "-c", script }, {
		count = PANEL_ID,
		cwd = cwd_override or go_root(),
		interactive = false, -- 不是交互 shell：不进 insert，也不靠 auto_close 收尾
		auto_close = false, -- 跑完不关，日志留在面板里
		win = {
			position = "bottom",
			height = PANEL_HEIGHT,
			backdrop = false,
			enter = false, -- 焦点留在编辑器，边写代码边看下面的输出
			-- 不写 winbar：lualine 接管了所有窗口的 winbar，跑了上面那行 echo 才能看清在跑什么
		},
	})
	if not term then
		Snacks.notify.error("运行面板创建失败")
	end
	return term
end

-- Ctrl-C 走 pty，前台进程组（go run 和它拉起的程序）一起收
local function stop()
	local t = panel()
	if not t then
		return
	end
	local job = vim.b[t.buf].terminal_job_id
	if job and vim.fn.jobwait({ job }, 0)[1] == -1 then
		vim.api.nvim_chan_send(job, "\003")
	else
		t:hide()
	end
end

-- 调试也用这一个面板：dlv dap 的 stdout 就是被调试程序的 stdout，
-- 把它跑在面板里，面板就变成了 IDEA 那个 Debug 控制台。
M.run = run

M.setup = function(map, opt)
	opt = opt or { noremap = true, silent = true }
	map("n", "<leader>rr", function()
		run("go run .")
	end, { desc = "运行面板: go run ." })
	map("n", "<leader>rb", function()
		run("go build ./...")
	end, { desc = "运行面板: go build ./..." })
	map("n", "<leader>rt", function()
		run("go test ./...")
	end, { desc = "运行面板: go test ./..." })
	map("n", "<leader>rp", function()
		local cmd = vim.fn.input("运行命令: ")
		vim.cmd("redraw!")
		if cmd ~= "" then
			run(cmd)
		end
	end, { desc = "运行面板: 自定义命令" })
	map("n", "<leader>rx", stop, { desc = "运行面板: 停止 / 收起" })
	map("n", "<leader>ro", function()
		local t = panel()
		if t then
			t:show():focus()
		end
	end, { desc = "运行面板: 聚焦（可翻页）" })
end

return M
