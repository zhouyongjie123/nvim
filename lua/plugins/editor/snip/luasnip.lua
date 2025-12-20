return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets", -- 通用片段库（含少量 Dart/Flutter）
	},
	config = function()
		local luasnip = require("luasnip")
		luasnip.setup({
			history = true, -- 记住上次选择的片段
			updateevents = "TextChanged,TextChangedI", -- 实时更新片段
			enable_autosnippets = true, -- 启用自动触发片段
		})
		local s = luasnip.snippet -- 定义片段
		local t = luasnip.text_node -- 文本节点（固定内容）
		local i = luasnip.insert_node -- 插入节点（可编辑内容）
		local f = luasnip.function_node -- 函数节点（动态内容）
		luasnip.add_snippets("dart", {
			s("stless", {
				-- 类名（可编辑，默认 MyWidget）
				t("class "),
				i(1, "MyWidget"),
				t(" extends StatelessWidget {"),
				-- 构造函数（复用类名，不可编辑）
				t({ "", "  /// 构造函数" }),
				t({
					"",
					"  const ",
					f(function(args)
						return args[1][1]
					end, { 1 }),
					"({super.key});",
				}),

				-- build 方法
				t({ "", "", "  @override" }),
				t({ "", "  Widget build(BuildContext context) {" }),
				-- 返回值（可编辑，默认 Container）
				t({ "", "    return " }),
				i(2, "Container()"),
				t(";"),
				t({ "", "  }" }),

				-- 类结束
				t({ "", "}" }),
				-- 最后光标定位到返回值位置
				i(0),
			}),
			s("stful", {
				-- 外部 Widget 类
				t("class "),
				i(1, "MyWidget"),
				t(" extends StatefulWidget {"),
				-- 构造函数
				t({ "", "  /// 构造函数" }),
				t({
					"",
					"  const ",
					f(function(args)
						return args[1][1]
					end, { 1 }),
					"({super.key});",
				}),

				-- createState 方法（返回内部 State 类）
				t({ "", "", "  @override" }),
				t({
					"",
					"  ",
					f(function(args)
						return "_" .. args[1][1] .. "State"
					end, { 1 }),
					" createState() => _",
				}),
				t(f(function(args)
					return args[1][1]
				end, { 1 })),
				t("State();"),
				t({ "", "}" }),

				-- 内部 State 类
				t({ "", "", "class _" }),
				f(function(args)
					return args[1][1]
				end, { 1 }),
				t("State extends State<"),
				f(function(args)
					return args[1][1]
				end, { 1 }),
				t(">" .. " {"),

				-- build 方法
				t({ "", "", "  @override" }),
				t({ "", "  Widget build(BuildContext context) {" }),
				-- 返回值（可编辑，默认 Container）
				t({ "", "    return " }),
				i(2, "Container()"),
				t(";"),
				t({ "", "  }" }),

				-- State 类结束
				t({ "", "}" }),
				-- 最后光标定位到返回值位置
				i(0),
			}),
		})
	end,
}
