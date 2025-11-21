return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- 安装/更新语法解析器
	event = { "BufReadPost", "BufNewFile" }, -- 打开文件时加载（延迟加载，优化启动速度）
	config = function()
		require("nvim-treesitter.configs").setup({
			-- 启用的功能
			ensure_installed = {
				-- 必装基础语言（根据你的使用场景增减）
				"lua",
				"vim",
				"vimdoc", -- Neovim 配置相关
				"python",
				"javascript",
				"typescript",
				"html",
				"css", -- 前端/后端
				"bash",
				"json",
				"yaml",
				"toml", -- 脚本/配置
				"markdown",
				"markdown_inline", -- 文档
			},
			sync_install = false, -- 不同步安装（避免阻塞）
			auto_install = true, -- 打开未支持的文件时，自动安装对应的语法解析器
			highlight = {
				enable = true, -- 启用语法高亮（核心功能）
				additional_vim_regex_highlighting = false, -- 禁用原生正则高亮（避免冲突）
			},
			indent = {
				enable = true, -- 启用智能缩进（部分语言不支持，可后续禁用）
				-- 可选：禁用某些语言的缩进（比如 Python 原生缩进已很好，可关闭）
				-- disable = { "python" }
			},
			incremental_selection = {
				enable = true, -- 启用增量选择
				keymaps = {
					init_selection = "<CR>", -- 初始化选择（按回车开始）
					node_incremental = "<CR>", -- 扩大选择（继续按回车）
					node_decremental = "<BS>", -- 缩小选择（按退格）
				},
			},
		})
	end,
}
