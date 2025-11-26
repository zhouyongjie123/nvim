return {
	-- LSP 核心
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"mfussenegger/nvim-jdtls",
	},
	opts = {
		servers = {
			jdtls = {},
			vue_ls = {},
			vtsls = {},
			marksman = {},
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
			jdtls = function()
				return true -- avoid duplicate servers
			end,

			clangd = function(_, opts)
				-- local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")

				local clangd_ext_opts = {
					extensions = {
						autoSetHints = true,
						inlay_hints = {
							show_parameter_hints = true,
							parameter_hints_prefix = "<- ",
							other_hints_prefix = "=> ",
						},
						ast = {
							role_icons = {
								type = "",
								declaration = "",
								expression = "",
								specifier = "",
								statement = "",
								["template argument"] = "",
							},
							kind_icons = {
								Compound = "",
								Recovery = "",
								TranslationUnit = "",
								PackExpansion = "",
								TemplateTypeParm = "",
								TemplateTemplateParm = "",
								TemplateParamObject = "",
							},
						},
					},
				}
				require("clangd_extensions").setup(
					vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
				)
				return false
			end,
		},
	},
	config = function() end,
}
