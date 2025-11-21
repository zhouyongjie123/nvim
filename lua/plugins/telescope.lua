return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.1.9",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local set = vim.keymap.set
		local builtin = require("telescope.builtin")
		set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
}
