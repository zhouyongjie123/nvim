vim.g.maplocalleader = " "
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config/keymaps")
require("config/options")

require("lazy").setup({
	spec = {
		{ import = "overseer" },
		{ import = "plugins" },
		{ import = "plugins.lang.lua" },
		{ import = "plugins.lang.python" },
		{ import = "plugins.lang.java" },
		{ import = "plugins.lang.c" },
		{ import = "plugins.lang.dart" },
		{ import = "plugins.dap" },
		{ import = "plugins.ui" },
		{ import = "plugins.lsp-common" },
		{ import = "plugins.editor" },
		{ import = "plugins.editor.snip.luasnip" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
	ui = {
		border = "rounded",
	},
})
