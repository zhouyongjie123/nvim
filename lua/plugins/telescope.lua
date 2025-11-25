return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.1.9",
	dependencies = { "nvim-lua/plenary.nvim" },
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

		require("telescope").setup(opts)

		local set = vim.keymap.set
		local builtin = require("telescope.builtin")
		set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
}
