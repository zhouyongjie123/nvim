local buf = vim.lsp.buf
local M = {}

-- IDEA 的 Find Usages：光标放在函数名/变量名上，看整个项目里谁用了它。
-- 挂了 LSP 就走 LSP（gopls 返回真正的引用，同名字符串和注释不会混进来）；
-- yaml / json / md 这类没有 LSP 的文件退回全项目按词 grep，按了至少不会没反应。
local function find_usages()
	-- snacks 的两个默认值和“查找用法”正好相反，都得关掉：
	-- auto_confirm=true 只剩一条结果就直接跳走、列表根本不出现；
	-- lsp_references 的 include_current=false 还会把光标所在那一条（声明本身）剔掉。
	if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
		require("snacks").picker.lsp_references({ include_current = true, auto_confirm = false })
	else
		require("snacks").picker.grep_word({ auto_confirm = false })
	end
end

M.setup = function(map, opt)
	map("n", "<leader>sh", buf.hover, opt)
	map({ "n", "x" }, "<leader>su", find_usages, { noremap = true, silent = true, desc = "查找用法 (Find Usages)" })

	-- Call Hierarchy（类似 IDEA 的 Hierarchy 功能）
	map("n", "<leader>sch", function()
		require("snacks").picker.lsp_incoming_calls()
	end, { noremap = true, silent = true, desc = "被谁调用 (Incoming Calls)" })
	map("n", "<leader>sco", function()
		require("snacks").picker.lsp_outgoing_calls()
	end, { noremap = true, silent = true, desc = "调用了谁 (Outgoing Calls)" })

	map("n", "<C-k>", buf.signature_help, opt)
	map("n", "<leader>rn", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, { expr = true })
	map({ "n", "v" }, "<leader>ca", function()
		buf.code_action({
			context = {
				only = { "quickfix", "refactor", "source" },
				diagnostics = {},
			},
		})
	end, { noremap = true, silent = true, desc = "code_action" })
	map({ "n", "i" }, "<M-CR>", function()
		buf.code_action({
			context = {
				only = { "quickfix" },
				diagnostics = {},
			},
		})
	end)

	map("n", "ge", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { noremap = true, desc = "goto next error" })
	map("n", "gE", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { noremap = true, desc = "goto previous error" })
end
return M
