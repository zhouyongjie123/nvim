local M = {}
M.nvimTreeList = {
	{
		key = { "<CR>", "o", "<2-LeftMouse>" },
		action = "edit",
	},
	{ key = "v", action = "vsplit" },
	{ key = "h", action = "split" },
	{ key = "i", action = "toggle_custom" },
	{ key = ".", action = "toggle_dotfiles" },
	{ key = "<F5>", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "s", action = "system_open" },
}
M.setup = function(map, opt)
	map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opt)
end
return M
