return {
	"stevearc/overseer.nvim",
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {
		-- -- 全局 UI 配置
		-- task_list = {
		-- 	position = "right", -- 任务列表侧边栏（模拟 IDEA 运行面板）
		-- 	width = 45,
		-- 	default_detail = 1, -- 显示任务详情
		-- },
		-- floating_win = { -- 运行终端的 UI（弹出式）
		-- 	border = "rounded",
		-- 	winblend = 10,
		-- 	height = 0.6, -- 终端高度占屏幕 60%
		-- 	width = 0.8, -- 终端宽度占屏幕 80%
		-- },
		-- templates = { "builtin", "user" }, -- 加载内置+自定义模板
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		-- ===================== 1. 自定义框架任务模板 =====================
		-- 模板：SpringBoot 运行（支持 mvn/gradle）
		-- overseer.register_template({
		-- 	name = "SpringBoot: Run",
		-- 	builder = function()
		-- 		local cmd = {}
		-- 		-- 自动检测项目构建工具（pom.xml → mvn，build.gradle → gradle）
		-- 		if vim.fn.filereadable("pom.xml") == 1 then
		-- 			cmd = { "mvn", "spring-boot:run" }
		-- 		elseif vim.fn.filereadable("build.gradle") == 1 then
		-- 			cmd = { "gradle", "bootRun" }
		-- 		else
		-- 			vim.notify("未找到 SpringBoot 构建文件", vim.log.levels.ERROR)
		-- 			return nil
		-- 		end
		-- 		return {
		-- 			name = "SpringBoot Run",
		-- 			cmd = cmd,
		-- 			cwd = vim.fn.getcwd(), -- 项目根目录执行
		-- 			components = {
		-- 				"default",
		-- 				"on_output_quickfix", -- 输出错误自动写入 quickfix
		-- 			},
		-- 		}
		-- 	end,
		-- 	-- 触发条件：项目根目录有 pom.xml/build.gradle + 文件类型为 java
		-- 	condition = {
		-- 		filetype = "java",
		-- 		callback = function()
		-- 			return vim.fn.filereadable("pom.xml") == 1 or vim.fn.filereadable("build.gradle") == 1
		-- 		end,
		-- 	},
		-- })
	end,
}
