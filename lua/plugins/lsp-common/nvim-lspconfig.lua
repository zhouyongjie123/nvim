return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
	},
	opts = {
		servers = {
			dartls = {},
			jdtls = {},
			vue_ls = {},
			vtsls = {},
			marksman = {},
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
			clangd = {
				keys = {
					{ "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
				},
				root_markers = {
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac", -- AutoTools
					"Makefile",
					"configure.ac",
					"configure.in",
					"config.h.in",
					"meson.build",
					"meson_options.txt",
					"build.ninja",
					".git",
				},
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			},
		},
		setup = {
			-- jdtls = function()
			-- 	return true -- avoid duplicate servers
			-- end,

			clangd = function(_, opts)
				local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
				require("clangd_extensions").setup(
					vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
				)
				return false
			end,
		},
	},
	config = function() end,
}
