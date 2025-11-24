return {
	-- Java LSP 支持
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			local config = {
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=INFO",
					"-Xmx4g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
					"-configuration",
					-- vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/config_linux"),
					(function()
						local os_name = vim.loop.os_uname().sysname
						if os_name == "Darwin" then
							return vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/config_mac")
						elseif os_name == "Windows_NT" then
							return vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/config_win")
						else -- Linux
							return vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/config_linux")
						end
					end)(),
					"-data",
					vim.fn.expand("~/.java-workspace/") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
					-- vim.fn.expand("~/.java-workspace/") .. vim.fn.sha256(vim.fn.getcwd()),
				},

				-- 根目录检测
				root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

				-- LSP 设置
				settings = {
					java = {
						signatureHelp = { enabled = true },
						contentProvider = { preferred = "fernflower" },
						completion = {
							favoriteStaticMembers = {
								"org.junit.Assert.*",
								"org.junit.Assume.*",
								"org.junit.jupiter.api.Assertions.*",
								"org.junit.jupiter.api.Assumptions.*",
								"org.mockito.Mockito.*",
								"org.mockito.ArgumentMatchers.*",
								"org.hamcrest.MatcherAssert.*",
								"org.hamcrest.Matchers.*",
							},
							filteredTypes = {
								"com.sun.*",
								"io.micrometer.shaded.*",
								"java.awt.*",
								"jdk.*",
								"sun.*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
						codeGeneration = {
							toString = {
								template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
							},
							hashCodeEquals = {
								useJava7Objects = true,
							},
							useBlocks = true,
						},
					},
				},

				-- 修复：延迟初始化
				on_init = function(client)
					-- 延迟设置，确保缓冲区已完全初始化
					vim.defer_fn(function()
						-- 确保缓冲区存在且有效
						local bufnr = vim.api.nvim_get_current_buf()
						if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) ~= "" then
							require("jdtls.setup").add_commands()
						end
					end, 100)
				end,

				-- 快捷键映射
				on_attach = function(client, bufnr)
					-- 确保缓冲区有效
					if not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end

					require("config.java-code-keymaps").setup(bufnr)
				end,

				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			}

			-- 安全启动函数
			-- local function setup_jdtls()
			-- 	-- 确保当前缓冲区有效
			-- 	local bufnr = vim.api.nvim_get_current_buf()
			-- 	if not vim.api.nvim_buf_is_valid(bufnr) or vim.api.nvim_buf_get_name(bufnr) == "" then
			-- 		vim.defer_fn(setup_jdtls, 50)
			-- 		return
			-- 	end

			-- 	-- 启动 jdtls
			-- 	require("jdtls").start_or_attach(config)
			-- end

			-- -- 延迟启动
			-- vim.defer_fn(setup_jdtls, 100)
			-- 替换原有的 安全启动函数 和 延迟启动
			-- 直接启动，依赖 jdtls 自身的缓冲区处理
			require("jdtls").start_or_attach(config)
		end,
	},
}
