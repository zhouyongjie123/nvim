vim.g.maplocalleader = " " -- 或者你想要的本地leader键
vim.g.mapleader = " " -- 通常也一起设置全局leader
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
require("lazy").setup("plugins")

vim.cmd('colorscheme catppuccin')
