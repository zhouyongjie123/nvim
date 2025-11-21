return {
	-- 1. noice.nvim：命令行居中 + 消息管理
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify", -- 可选：通知美化
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
					-- you can enable a preset for easier configuration
					presets = {
						bottom_search = true, -- use a classic bottom cmdline for search
						command_palette = true, -- position the cmdline and popupmenu together
						long_message_to_split = true, -- long messages will be sent to a split
						inc_rename = false, -- enables an input dialog for inc-rename.nvim
						lsp_doc_border = false, -- add a border to hover docs and signature help
					},
				},
			})
		end,
	},

	-- 3. 可选：nvim-notify 美化通知（搭配 noice）
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				timeout = 3000,
				max_width = 100,
				stages = "fade_in_slide_out",
				render = "compact",
			})
			vim.notify = require("notify") -- 替换原生 notify
		end,
	},
}
