return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		local toggleterm = require("toggleterm")
		local Terminal = require("toggleterm.terminal").Terminal

		toggleterm.setup({
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true, -- 给终端添加阴影（提升视觉区分度）
			shading_factor = 2, -- 阴影深度（0-10，越大越暗）
			start_in_insert = true, -- 打开终端时自动进入插入模式
			insert_mappings = true, -- 允许在插入模式使用终端快捷键
			persist_size = true,
			persist_mode = true,
			direction = "float",
			close_on_exit = false,
			shell = vim.o.shell, -- 使用系统默认 shell
		})
	end,
}
