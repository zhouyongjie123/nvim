local map = vim.api.nvim_set_keymap
local del = vim.api.nvim_del_keymap
local set = vim.keymap.set
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
-- 删除操作（不复制到寄存器）
set("n", "d", '"_d', { desc = "Delete without copying to register" })
set("n", "dd", '"_dd', { desc = "Delete line without copying to register" })
set("n", "D", '"_D', { desc = "Delete to EOL without copying to register" })
set("v", "d", '"_d', { desc = "Delete visually selected without copying to register" })
set("n", "d<leader>", '"_diw', { desc = "Delete without copying to register" })

-- 修改操作（不复制到寄存器）
set("n", "c", '"_c', { desc = "Change without copying to register" })
set("v", "c", '"_c', { desc = "Change visually selected without copying to register" })
set("n", "cc", '"_cc', { desc = "Change line without copying to register" })
set("n", "c<leader>", '"_ciw', { desc = "Change without copying to register" })
-- 粘贴操作（先清空目标内容，再从系统剪贴板粘贴）
set("v", "p", '"_c<Esc>"+p', { desc = "Paste from system clipboard (overwrite)" })
set("v", "P", '"_c<Esc>"+P', { desc = "Paste before from system clipboard (overwrite)" })

-- 复制操作（复制到系统剪贴板）
set("v", "y", '"+y', { desc = "Copy to system clipboard" })
set("n", "yy", '"+yy', { desc = "Copy line to system clipboard" })

set("n", "<leader>ve", "ggVG", opts)

-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "x", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

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

-- Terminal相关
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
map("n", "J", "6j", opt)
map("n", "K", "6k", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>i", opt)
map("i", "<C-l>", "<ESC>la", opt)
map("i", "jj", "<ESC>", opt)
-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)
local pluginKeys = {}
-- 列表快捷键
pluginKeys.nvimTreeList = {
	-- 打开文件或文件夹
	{
		key = { "<CR>", "o", "<2-LeftMouse>" },
		action = "edit",
	},
	-- 分屏打开文件
	{ key = "v", action = "vsplit" },
	{ key = "h", action = "split" },
	-- 显示隐藏文件
	{ key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
	{ key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
	-- 文件操作
	{ key = "<F5>", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "s", action = "system_open" },
}
return pluginKeys
