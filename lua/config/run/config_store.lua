---@class RunConfig
---@field name string
---@field cmd string
---@field cwd? string
---@field env? table<string,string>
---@field tags? string[]

---@class RunConfigStore
local M = {}

local CONFIG_DIR = ".nvim"
local CONFIG_FILE = "run_configs.json"
local CONFIG_VERSION = 1

--- 获取项目根目录（向上查找 .git / go.mod / .nvim）
---@return string
function M.project_root()
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and path or vim.fn.getcwd()

	-- 优先查找 .git
	local git = vim.fs.find(".git", { upward = true, limit = 1, path = path })[1]
	if git then
		return vim.fs.dirname(git)
	end

	-- 其次查找 go.mod
	local mod = vim.fs.find("go.mod", { upward = true, limit = 1, path = path })[1]
	if mod then
		return vim.fs.dirname(mod)
	end

	-- 最后使用当前工作目录
	return vim.fn.getcwd()
end

--- 获取配置文件路径
---@return string
local function config_path()
	return M.project_root() .. "/" .. CONFIG_DIR .. "/" .. CONFIG_FILE
end

--- 读取当前项目的所有运行配置
---@return RunConfig[]
function M.load()
	local path = config_path()
	local file = io.open(path, "r")
	if not file then
		return {}
	end

	local content = file:read("*a")
	file:close()

	local ok, data = pcall(vim.json.decode, content)
	if not ok or not data or data.version ~= CONFIG_VERSION then
		return {}
	end

	return data.configs or {}
end

--- 简单的 JSON 美化（2 空格缩进）
---@param json string
---@return string
local function pretty_json(json)
	local result = ""
	local indent = 0
	local in_string = false
	local escape = false

	local i = 1
	while i <= #json do
		local c = json:sub(i, i)

		if escape then
			result = result .. c
			escape = false
		elseif c == "\\" and in_string then
			result = result .. c
			escape = true
		elseif c == '"' then
			result = result .. c
			in_string = not in_string
		elseif in_string then
			result = result .. c
		elseif c == "{" or c == "[" then
			result = result .. c .. "\n"
			indent = indent + 2
			result = result .. string.rep(" ", indent)
		elseif c == "}" or c == "]" then
			result = result .. "\n"
			indent = indent - 2
			result = result .. string.rep(" ", indent) .. c
		elseif c == "," then
			result = result .. ",\n" .. string.rep(" ", indent)
		elseif c == ":" then
			result = result .. ": "
		else
			result = result .. c
		end

		i = i + 1
	end

	return result
end

--- 保存配置列表到 JSON 文件
---@param configs RunConfig[]
function M.save(configs)
	local path = config_path()
	local dir = vim.fs.dirname(path)

	-- 确保目录存在
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	local data = {
		version = CONFIG_VERSION,
		configs = configs,
	}

	local json = vim.json.encode(data)
	json = pretty_json(json)

	local file = io.open(path, "w")
	if file then
		file:write(json)
		file:close()
	end
end

--- 追加一条配置并持久化
---@param config RunConfig
function M.add(config)
	local configs = M.load()

	-- 检查名称是否已存在
	for i, c in ipairs(configs) do
		if c.name == config.name then
			configs[i] = config
			M.save(configs)
			return
		end
	end

	table.insert(configs, config)
	M.save(configs)
end

--- 按 name 删除
---@param name string
function M.remove(name)
	local configs = M.load()
	local new_configs = {}
	for _, c in ipairs(configs) do
		if c.name ~= name then
			table.insert(new_configs, c)
		end
	end
	M.save(new_configs)
end

--- 按 name 更新
---@param name string
---@param config RunConfig
function M.update(name, config)
	local configs = M.load()
	for i, c in ipairs(configs) do
		if c.name == name then
			config.name = name -- 保持原名
			configs[i] = config
			M.save(configs)
			return
		end
	end
end

return M
