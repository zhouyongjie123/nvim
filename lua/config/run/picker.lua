local M = {}

--- 自定义 format：显示配置名 + 命令预览
---@param item snacks.picker.finder.Item
---@param picker snacks.Picker
---@return snacks.picker.Highlight[]
local function format(item, picker)
	local ret = {} ---@type snacks.picker.Highlight[]
	local config = item.item ---@type RunConfig

	-- 图标
	ret[#ret + 1] = { "▶ ", "SnacksPickerRunIcon" }

	-- 名称（固定宽度对齐）
	local name = config.name
	if #name > 25 then
		name = name:sub(1, 22) .. "..."
	else
		name = name .. string.rep(" ", 25 - #name)
	end
	ret[#ret + 1] = { name, "SnacksPickerRunName" }

	-- 命令（灰色）
	ret[#ret + 1] = { "  " }
	ret[#ret + 1] = { config.cmd, "Comment" }

	-- tags
	if config.tags and #config.tags > 0 then
		ret[#ret + 1] = { "  " }
		ret[#ret + 1] = { "#" .. table.concat(config.tags, " #"), "SnacksPickerRunTags" }
	end

	return ret
end

--- Finder：从 config_store 加载所有配置，转为 picker items
---@param opts table
---@param ctx snacks.picker.Context
---@return snacks.picker.finder.Item[]
local function finder(opts, ctx)
	local store = require("config.run.config_store")
	local configs = store.load()
	local items = {} ---@type snacks.picker.finder.Item[]

	for _, config in ipairs(configs) do
		-- text 字段用于模糊搜索匹配
		local search_text = config.name .. " " .. config.cmd .. " " .. table.concat(config.tags or {}, " ")
		items[#items + 1] = {
			text = search_text,
			item = config,
			title = config.name,
		}
	end

	return items
end

--- Confirm action：关闭 picker，执行选中的配置
---@param picker snacks.Picker
---@param item snacks.picker.finder.Item
local function confirm(picker, item)
	picker:close()
	if not item then
		return
	end
	local config = item.item ---@type RunConfig
	vim.schedule(function()
		require("config.run").execute(config)
	end)
end

--- 新建配置 action
---@param picker snacks.Picker
local function action_new(picker)
	picker:close()
	vim.schedule(function()
		local create = require("config.run.create")
		create.interactive_create(function(config)
			local store = require("config.run.config_store")
			store.add(config)
			Snacks.notify("运行配置已创建: " .. config.name)
		end)
	end)
end

--- 删除配置 action
---@param picker snacks.Picker
---@param item snacks.picker.finder.Item
local function action_delete(picker, item)
	if not item then
		return
	end
	local config = item.item ---@type RunConfig
	local store = require("config.run.config_store")
	store.remove(config.name)
	Snacks.notify("已删除: " .. config.name)
	-- 刷新列表
	picker:refresh()
end

--- 编辑配置 action
---@param picker snacks.Picker
---@param item snacks.picker.finder.Item
local function action_edit(picker, item)
	if not item then
		return
	end
	picker:close()
	vim.schedule(function()
		local old_config = item.item ---@type RunConfig
		local create = require("config.run.create")
		local Snacks = require("snacks")

		-- 依次修改各字段
		Snacks.input({ prompt = "配置名称: ", icon = "▶", default = old_config.name }, function(name)
			if not name or name == "" then
				return
			end
			Snacks.input({ prompt = "运行命令: ", icon = "$", default = old_config.cmd }, function(cmd)
				if not cmd or cmd == "" then
					return
				end
				Snacks.input({
					prompt = "工作目录: ",
					icon = " ",
					default = old_config.cwd or ".",
				}, function(cwd)
					cwd = (cwd and cwd ~= "") and cwd or "."
					local def_tags = table.concat(old_config.tags or {}, ",")
					Snacks.input({ prompt = "标签: ", icon = "#", default = def_tags }, function(tags_str)
						local tags = {}
						if tags_str and tags_str ~= "" then
							for tag in tags_str:gmatch("[^,]+") do
								tag = vim.trim(tag)
								if tag ~= "" then
									table.insert(tags, tag)
								end
							end
						end

						local new_config = {
							name = name,
							cmd = cmd,
							cwd = cwd,
							env = {},
							tags = tags,
						}

						local store = require("config.run.config_store")
						-- 如果名称变了，先删旧的
						if old_config.name ~= name then
							store.remove(old_config.name)
						end
						store.add(new_config)
						Snacks.notify("运行配置已更新: " .. name)
					end)
				end)
			end)
		end)
	end)
end

--- 打开运行配置 picker
function M.open()
	local Snacks = require("snacks")

	-- 检查是否有配置，没有则提示新建
	local store = require("config.run.config_store")
	local configs = store.load()

	if #configs == 0 then
		-- 没有配置，直接打开新建流程
		Snacks.notify.info("暂无运行配置，请先创建一个")
		require("config.run.create").interactive_create(function(config)
			store.add(config)
			Snacks.notify("运行配置已创建: " .. config.name)
			-- 创建后打开 picker
			vim.schedule(function()
				M.open()
			end)
		end)
		return
	end

	Snacks.picker({
		finder = finder,
		format = format,
		confirm = confirm,
		title = "运行配置",
		layout = { preset = "telescope" },
		matcher = { fuzzy = true, sort_empty = true },
		actions = {
			run_config_new = action_new,
			run_config_delete = action_delete,
			run_config_edit = action_edit,
		},
		win = {
			input = {
				keys = {
					["<C-j>"] = { "list_down", mode = { "n", "i" } },
					["<C-k>"] = { "list_up", mode = { "n", "i" } },
					["<C-n>"] = { "run_config_new", mode = { "n", "i" } },
					["<C-d>"] = { "run_config_delete", mode = { "n", "i" } },
					["<C-e>"] = { "run_config_edit", mode = { "n", "i" } },
				},
			},
		},
	})
end

return M
