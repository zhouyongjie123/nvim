local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
ls.add_snippets("dart", {
	s("stl", {
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
	s("stf", {
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
