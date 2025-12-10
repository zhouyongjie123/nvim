return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			-- 前端文件：先 eslint 修复语法，再 prettier 格式化
			javascript = { "eslint_d", "prettier" },
			typescript = { "eslint_d", "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			-- Python：black
			python = { "black" },
			-- Go：gofmt
			go = { "gofmt", "goimports" }, -- goimports 自动整理导入
			-- Rust：rustfmt
			rust = { "rustfmt" },
			-- 其他文件类型（默认使用 LSP 格式化）
			["*"] = { "trim_whitespace" },
		},
		-- 自定义工具参数（按需配置）
		formatters = {
			prettier = {
				extra_args = { "--single-quote", "--tab-width", "2" },
			},
			black = {
				extra_args = { "--line-length", "120" },
			},
		},
	},
	keys = {
		{
			"<M-F>",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "手动格式化文件",
		},
	},
}
