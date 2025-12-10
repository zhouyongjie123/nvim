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
-- require("lazy").setup("plugins")

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" }, -- 导入`./lua/plugins/`目录下的所有lua文件
		{ import = "plugins.lang.lua" }, -- 导入`./lua/plugins/lang/lua/`目录下的所有lua文件
		{ import = "plugins.ui" }, -- 导入`./lua/plugins/ui/`目录下的所有lua文件
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
	ui = {
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "rounded",
	},
})
