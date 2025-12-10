local map = vim.keymap.set
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
-- 粘贴操作（先清空目标内容，再从系统剪贴板粘贴）
-- map("v", "p", '"_c<Esc>"+p', { desc = "Paste from system clipboard (overwrite)" })
-- map("v", "P", '"_c<Esc>"+P', { desc = "Paste before from system clipboard (overwrite)" })

-- 复制操作（复制到系统剪贴板）
-- map("v", "y", '"+y', { desc = "Copy to system clipboard" })
-- map("n", "yy", '"+yy', { desc = "Copy line to system clipboard" })

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

-- 在visual 模式里粘贴不要复制
-- map("v", "p", '"_dP', opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>i", opt)
map("i", "<C-l>", "<ESC>la", opt)
map("i", "jj", "<ESC>", opt)

require("config.bufferline-keymaps").setup(map, opt)
require("config.nvim-tree-keymaps").setup(map, opt)
require("config.code-keymaps").setup(map, opt)
require("config.yanky-keymaps").setup(map, opt)
