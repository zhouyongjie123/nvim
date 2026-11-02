local M = {}

--- 执行一个运行配置
---@param config RunConfig
function M.execute(config)
	local store = require("config.run.config_store")
	local root = store.project_root()

	-- 构建带环境变量的命令
	local cmd = config.cmd
	if config.args and #config.args > 0 then
		cmd = cmd .. " " .. table.concat(config.args, " ")
	end

	-- 处理环境变量前缀
	local env_prefix = ""
	if config.env and next(config.env) then
		local parts = {}
		for k, v in pairs(config.env) do
			parts[#parts + 1] = k .. "=" .. vim.fn.shellescape(v)
		end
		env_prefix = table.concat(parts, " ") .. " "
	end

	local full_cmd = env_prefix .. cmd

	-- 计算工作目录
	local cwd = config.cwd or "."
	if cwd ~= "." and not vim.startswith(cwd, "/") then
		cwd = root .. "/" .. cwd
	elseif cwd == "." then
		cwd = root
	end

	-- 复用 go-run-keymaps 的终端面板
	local runner = require("config.keymaps.go-run-keymaps")
	runner.run(full_cmd, config.name, cwd)
end

--- 注册 :Run 命令
function M.setup()
	vim.api.nvim_create_user_command("Run", function()
		require("config.run.picker").open()
	end, { desc = "打开运行配置选择器" })
end

return M
