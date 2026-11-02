return {
	"ray-x/material_plus.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.material_style = "palenight"
		vim.cmd.colorscheme("palenight")
	end,
}
