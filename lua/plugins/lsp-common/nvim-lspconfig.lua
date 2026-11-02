return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
	},
	opts = {
		servers = {
			dartls = {},
			vue_ls = {},
			vtsls = {},
			marksman = {},
			-- 实际配置见 after/lsp/gopls.lua（本表当前无代码消费）
			gopls = {},
			ruff = {
				cmd_env = { RUFF_TRACE = "messages" },
				init_options = {
					settings = {
						logLevel = "error",
					},
				},
			},
			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							diagnosticMode = "off",
							typeCheckingMode = "off",
							reportMissingTypeAnnotations = "none",
							reportUnusedVariable = "none",
							reportUnusedImport = "none",
							exclude = {
								"**/venv/**",
								"**/__pycache__/**",
								"**/build/**",
								"**/*.pyc",
							},
							venvPath = vim.fn.getenv("VIRTUAL_ENV") or vim.fn.getcwd() .. "/venv",
							pythonPath = vim.fn.exepath("python3") or vim.fn.getcwd() .. "/venv/bin/python3",
							inlayHints = {
								callArgumentNames = true,
							},
						},
					},
				},
			},
		},
		setup = {},
	},
	config = function() end,
}
