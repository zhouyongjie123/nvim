local map = vim.keymap.set
-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map(
	"n",
	"<leader>nh",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)
-- 优化搜索方向
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- save file
map({ "i", "x", "n", "s" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save File" })
-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- lazygit
if vim.fn.executable("lazygit") == 1 then
	map("n", "<leader>gg", function()
		Snacks.lazygit({ cwd = LazyVim.root.git() })
	end, { desc = "Lazygit (Root Dir)" })
	map("n", "<leader>gG", function()
		Snacks.lazygit()
	end, { desc = "Lazygit (cwd)" })
end

map("n", "<leader>gL", function()
	Snacks.picker.git_log()
end, { desc = "Git Log (cwd)" })
map("n", "<leader>gb", function()
	Snacks.picker.git_log_line()
end, { desc = "Git Blame Line" })
map("n", "<leader>gf", function()
	Snacks.picker.git_log_file()
end, { desc = "Git Current File History" })
map("n", "<leader>gl", function()
	Snacks.picker.git_log({ cwd = LazyVim.root.git() })
end, { desc = "Git Log" })
map({ "n", "x" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
map({ "n", "x" }, "<leader>gY", function()
	Snacks.gitbrowse({
		open = function(url)
			vim.fn.setreg("+", url)
		end,
		notify = false,
	})
end, { desc = "Git Browse (copy)" })

-- toggle options
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.indent():map("<leader>ug")

if vim.lsp.inlay_hint then
	Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- 复用 opt 参数
local opt = { noremap = true, silent = true }
-- 删除操作（不复制到寄存器）
map("n", "d", '"_d', { desc = "Delete without copying to register" })
map("n", "dd", '"_dd', { desc = "Delete line without copying to register" })
map("n", "D", '"_D', { desc = "Delete to EOL without copying to register" })
map("v", "d", '"_d', { desc = "Delete visually selected without copying to register" })
map("n", "d<leader>", '"_diw', { desc = "Delete without copying to register" })

-- 修改操作（不复制到寄存器）
map("n", "c", '"_c', { desc = "Change without copying to register" })
map("v", "c", '"_c', { desc = "Change visually selected without copying to register" })
map("n", "cc", '"_cc', { desc = "Change line without copying to register" })
map("n", "c<leader>", '"_ciw', { desc = "Change without copying to register" })

map("n", "<leader>ve", "ggVG", opt)

-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "x", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- 窗口之间跳转
map("n", "<M-h>", "<C-w>h", opt)
map("n", "<M-j>", "<C-w>j", opt)
map("n", "<M-k>", "<C-w>k", opt)
map("n", "<M-l>", "<C-w>l", opt)
-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
map("n", "J", "6j", opt)
map("n", "K", "6k", opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>i", opt)
map("i", "<C-l>", "<ESC>la", opt)
map("i", "jj", "<ESC>", opt)

require("config.keymaps.bufferline-keymaps").setup(map, opt)
require("config.keymaps.nvim-tree-keymaps").setup(map, opt)
require("config.keymaps.code-keymaps").setup(map, opt)
require("config.keymaps.yanky-keymaps").setup(map, opt)
