return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" }, -- 打开文件时加载
	opts = {
		install_dir = vim.fn.stdpath("data") .. "/site/parser/",
		ensure_installed = {
			"vim",
			"vimdoc",
			"python",
			"javascript",
			"typescript",
			"html",
			"bash",
			"json",
			"yaml",
			"toml", -- 脚本/配置
			"markdown",
			"markdown_inline", -- 文档
			"vue",
			"css",
			"go",
			"git_config",
			"gitcommit",
			"git_rebase",
			"gitignore",
			"gitattributes",
		},
		auto_install = true, -- 打开未支持的文件时，自动安装对应的语法解析器
		highlight = {
			enable = true, -- 启用语法高亮
			additional_vim_regex_highlighting = false, -- 禁用原生正则高亮
		},
	},
	opts_extend = { "ensure_installed" },
}
