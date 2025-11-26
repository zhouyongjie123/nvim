return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	ft = { "java" },
	opts = function()
		-- 查找 jdtls 可执行文件（Mason 安装的路径或系统路径）
		local jdtls_path = vim.fn.exepath("jdtls")
		local cmd = jdtls_path and { jdtls_path } or { "jdtls" } -- 降级处理

		-- Mason 安装的 lombok.jar 路径（如果用 Mason 管理）
		local lombok_jar = vim.fn.expand("$MASON/share/jdtls/lombok.jar")
		if vim.fn.filereadable(lombok_jar) then
			table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
		end

		return {
			root_dir = function(path)
				-- 自定义根目录检测（支持 gradle/maven 项目）
				local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
				return vim.fs.root(path, root_markers) or vim.fn.getcwd()
			end,

			project_name = function(root_dir)
				return root_dir and vim.fs.basename(root_dir) or "unnamed_project"
			end,

			jdtls_config_dir = function(project_name)
				return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
			end,
			jdtls_workspace_dir = function(project_name)
				return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
			end,

			cmd = cmd,
			full_cmd = function(opts)
				local fname = vim.api.nvim_buf_get_name(0)
				local root_dir = opts.root_dir(fname)
				local project_name = opts.project_name(root_dir)
				local cmd = vim.deepcopy(opts.cmd)
				if project_name then
					vim.list_extend(cmd, {
						"-configuration",
						opts.jdtls_config_dir(project_name),
						"-data",
						opts.jdtls_workspace_dir(project_name),
					})
				end
				return cmd
			end,

			-- DAP 配置
			dap = { hotcodereplace = "auto", config_overrides = {} },
			dap_main = {}, -- 启用主类扫描
			test = true, -- 启用测试功能
			settings = {
				java = {
					inlayHints = {
						parameterNames = { enabled = "all" },
					},
					format = {
						enabled = true,
						settings = {
							url = vim.fn.stdpath("config") .. "/lang-servers/eclipse-java-google-style.xml",
							profile = "GoogleStyle",
						},
					},
				},
			},
			-- 用户自定义 on_attach（可选）
			on_attach = nil,
		}
	end,
	config = function(_, opts)
		-- 查找调试插件的 bundles（java-debug-adapter/java-test）
		local bundles = {}
		local mason_ok, mason_registry = pcall(require, "mason-registry")
		if mason_ok then
			-- 检查 java-debug-adapter 是否安装
			if opts.dap and pcall(require, "dap") and mason_registry.is_installed("java-debug-adapter") then
				local debug_bundles =
					vim.fn.glob("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar", false, true)
				vim.list_extend(bundles, debug_bundles)

				-- 检查 java-test 是否安装
				if opts.test and mason_registry.is_installed("java-test") then
					local test_bundles = vim.fn.glob("$MASON/share/java-test/*.jar", false, true)
					vim.list_extend(bundles, test_bundles)
				end
			end
		end

		-- 合并配置的辅助函数
		local function extend_or_override(base, override)
			if not override then
				return base
			end
			for k, v in pairs(override) do
				if type(v) == "table" and type(base[k]) == "table" then
					base[k] = extend_or_override(base[k], v)
				else
					base[k] = v
				end
			end
			return base
		end

		-- 启动或附加 jdtls 的函数
		local function attach_jdtls()
			local fname = vim.api.nvim_buf_get_name(0)
			local root_dir = opts.root_dir(fname)

			-- 构建 LSP 配置
			local base_config = {
				cmd = opts.full_cmd(opts),
				root_dir = root_dir,
				init_options = {
					bundles = bundles,
				},
				settings = opts.settings,
				-- LSP 能力
				capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					pcall(require, "cmp_nvim_lsp") and require("cmp_nvim_lsp").default_capabilities() or {}
				),
				-- 自定义 on_attach
				on_attach = function(client, bufnr)
					-- 若用户配置了 on_attach，执行它
					if opts.on_attach then
						opts.on_attach(client, bufnr)
					end

					-- 手动设置快捷键（替代 which-key）
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
					end

					-- 调试/测试快捷键（如果启用）
					if
						opts.dap
						and pcall(require, "dap")
						and mason_registry
						and mason_registry.is_installed("java-debug-adapter")
					then
						require("jdtls").setup_dap(opts.dap)
						if opts.dap_main then
							require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
						end

						-- 测试相关快捷键
						if opts.test and mason_registry.is_installed("java-test") then
							map("n", "<leader>tt", function()
								require("jdtls.dap").test_class({
									config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides
										or nil,
								})
							end, "Run All Tests")

							map("n", "<leader>tr", function()
								require("jdtls.dap").test_nearest_method({
									config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides
										or nil,
								})
							end, "Run Nearest Test")

							map("n", "<leader>tT", require("jdtls.dap").pick_test, "Pick Test")
						end
					end
					vim.api.nvim_create_user_command("RunDap", function()
						require("dap").continue()
					end, {})
				end,
			}

			-- 合并用户自定义的 jdtls 配置
			local config = extend_or_override(base_config, opts.jdtls)

			-- 启动 jdtls
			require("jdtls").start_or_attach(config)
		end

		-- 为 Java 文件自动附加 LSP
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "java" },
			callback = attach_jdtls,
			group = vim.api.nvim_create_augroup("nvim_jdtls_attach", { clear = true }),
		})

		-- 首次加载时手动触发 attach（避免 autocmd 延迟）
		if vim.bo.filetype == "java" then
			attach_jdtls()
		end
	end,
}
