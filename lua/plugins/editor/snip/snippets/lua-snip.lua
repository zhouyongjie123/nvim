local ls = require("luasnip")
local s = ls.s -- 定义片段（snippet）
local i = ls.insert_node -- 插入节点（可编辑位置）
local fmt = require("luasnip.extras.fmt").fmt -- 格式化字符串，简化片段编写
ls.add_snippets("lua", {
	-- 核心片段：触发键为 ".local"，实现你需要的功能
	s(
		{
			trig = ".local", -- 触发字符：输入 {} 后，输入 .local 触发
			name = "Local Module Table", -- 片段名称（可选，用于提示）
			dscr = "快速补全 local M = {} （自定义变量名）", -- 片段描述（可选）
			wordTrig = false, -- 关键配置：允许触发键以 . 开头（默认true会忽略标点开头的trigger）
		},
		-- 片段模板：fmt格式化，{} 对应后续的插入节点
		-- 模板说明：local [可选变量名] = {}，默认值M，可编辑
		fmt("local {} = {}", {
			i(1, "M"), -- 第一个可编辑位置，默认值"M"，可输入自定义变量名
			i(2), -- 第二个可编辑位置（可选，光标默认停在第一个位置，按Tab切换到这里）
		})
	),
})
