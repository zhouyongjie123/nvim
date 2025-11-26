return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "BufEnter", -- 触发时机：打开文件时加载（优化性能）
		config = function()
			-- 手动初始化 bufferline
			local bufferline = require("bufferline")

			bufferline.setup({
				options = {
					show_buffer_icons = true, -- 显示图标（依赖 web-devicons）
					show_buffer_close_icons = true, -- 显示关闭按钮
					show_close_icon = false,
					show_tab_indicators = true,
					persist_buffer_sort = true, -- 保存排序
					separator_style = "slant", -- 分隔线样式（可选：slant/pipe/thick/thin）
					always_show_bufferline = true, -- 强制显示（即使只有1个buffer）

					offsets = {
						{
							filetype = "NvimTree",
							text = "file tree",
							text_align = "left",
							separator = true,
						},
					},
				},
			})
		end,
	},
}
