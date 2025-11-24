local keymap = vim.keymap.set
-- 跳转到声明
-- keymap("n", "gD", vim.lsp.buf.declaration, opts)
-- 跳转到定义
keymap("n", "gd", vim.lsp.buf.definition, opts)
-- 查看文档注释（hover）
keymap("n", "<leader>sh", vim.lsp.buf.hover, opts)
-- 跳转到实现
keymap("n", "gi", vim.lsp.buf.implementation, opts)
-- 查看签名帮助（参数提示）
keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
-- 添加工作区文件夹
-- keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
-- 移除工作区文件夹
-- keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
-- 列出工作区文件夹
keymap("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
-- 跳转到类型定义（如类、接口）
-- keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
-- 重命名变量/方法
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- 代码动作（修复建议、重构等）
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
-- 查看引用
keymap("n", "gr", vim.lsp.buf.references, opts)
