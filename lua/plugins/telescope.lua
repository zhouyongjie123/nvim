return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.1.9",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- 图标支持
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local opts = {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- 下拉菜单样式（紧凑、无预览，适合 code_action 短列表）
						layout_config = {
							width = 0.8, -- 浮窗宽度占比
							height = 0.4, -- 浮窗高度占比
						},
						previewer = false, -- 关闭预览（code_action 无需预览）
						prompt_title = false, -- 隐藏标题栏，更简洁
					}),
				},
			},
			pickers = {
				lsp_code_actions = {
					theme = "cursor",
					layout_config = {
						width = 0.8,
						height = 0.4,
					},
				},
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = { "--hidden" },
				},
			},
		}

		local telescope = require("telescope")
		telescope.setup(opts)

		local set = vim.keymap.set
		local builtin = require("telescope.builtin")
		set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		telescope.load_extension("ui-select")
	end,
}
