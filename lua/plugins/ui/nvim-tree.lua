return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- 显示 git 状态图标
			git = {
				enable = true,
			},
			-- project plugin 需要这样设置
			update_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			-- 隐藏 .文件 和 node_modules 文件夹
			filters = {
				dotfiles = true,
				custom = { "node_modules" },
			},
			view = {
				-- 宽度
				width = 40,
				-- 也可以 'right'
				side = "left",
				-- 不显示行数
				number = false,
				relativenumber = false,
				-- 显示图标
				signcolumn = "yes",
			},
			actions = {
				open_file = {
					-- 首次打开大小适配
					resize_window = true,
					-- 打开文件后保持目录树开启
					quit_on_open = false,
				},
			},
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)

			-- 显示/隐藏隐藏文件命令
			vim.api.nvim_create_user_command("ShowDotFile", function()
				local explorer = require("nvim-tree.core").get_explorer()
				if explorer and explorer.filters.state.dotfiles then
					require("nvim-tree.api").filter.dotfiles.toggle()
				end
			end, { desc = "显示隐藏文件" })

			vim.api.nvim_create_user_command("HideDotFile", function()
				local explorer = require("nvim-tree.core").get_explorer()
				if explorer and not explorer.filters.state.dotfiles then
					require("nvim-tree.api").filter.dotfiles.toggle()
				end
			end, { desc = "隐藏隐藏文件" })
		end,
	},
}
