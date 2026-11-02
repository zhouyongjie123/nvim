local M = {}

--- 根据当前文件类型获取默认命令
---@return string
local function default_cmd()
	local ft = vim.bo.filetype
	if ft == "go" then
		local name = vim.api.nvim_buf_get_name(0)
		if name:match("_test%.go$") then
			return "go test ./..."
		end
		return "go run ."
	elseif ft == "python" then
		return "python3 %"
	elseif ft == "lua" then
		return "lua %"
	elseif ft == "javascript" or ft == "typescript" then
		return "node %"
	elseif ft == "rust" then
		return "cargo run"
	elseif ft == "java" then
		return "mvn spring-boot:run"
	end
	return ""
end

--- 根据当前文件类型获取默认标签
---@return string[]
local function default_tags()
	local ft = vim.bo.filetype
	if ft == "" then
		return {}
	end
	return { ft }
end

--- 交互式创建运行配置
---@param on_done fun(config: RunConfig)
function M.interactive_create(on_done)
	local Snacks = require("snacks")

	-- Step 1: 输入名称
	Snacks.input({ prompt = "配置名称: ", icon = "▶" }, function(name)
		if not name or name == "" then
			Snacks.notify.warn("已取消创建")
			return
		end

		-- Step 2: 输入命令
		local def_cmd = default_cmd()
		Snacks.input({ prompt = "运行命令: ", icon = "$", default = def_cmd }, function(cmd)
			if not cmd or cmd == "" then
				Snacks.notify.warn("已取消创建")
				return
			end

			-- Step 3: 工作目录（可选）
			Snacks.input({ prompt = "工作目录 (相对项目根, 默认 .): ", icon = " ", default = "." }, function(cwd)
				cwd = (cwd and cwd ~= "") and cwd or "."

				-- Step 4: 标签（可选）
				local def_tags = table.concat(default_tags(), ",")
				Snacks.input({ prompt = "标签 (逗号分隔, 可选): ", icon = "#", default = def_tags }, function(tags_str)
					local tags = {}
					if tags_str and tags_str ~= "" then
						for tag in tags_str:gmatch("[^,]+") do
							tag = vim.trim(tag)
							if tag ~= "" then
								table.insert(tags, tag)
							end
						end
					end

					local config = {
						name = name,
						cmd = cmd,
						cwd = cwd,
						env = {},
						tags = tags,
					}

					on_done(config)
				end)
			end)
		end)
	end)
end

return M
