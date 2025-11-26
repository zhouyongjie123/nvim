local buf = vim.lsp.buf
local M = {}
M.setup = function(map, opt)
	-- 跳转到声明
	-- keymap("n", "gD", vim.lsp.buf.declaration, opts)
	map("n", "gd", buf.definition, opt)
	map("n", "<leader>sh", buf.hover, opt)
	map("n", "gi", buf.implementation, opt)
	map("n", "<C-k>", buf.signature_help, opt)
	-- 跳转到类型定义（如类、接口）
	-- keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	map("n", "<leader>rn", buf.rename, opt)
	map("n", "gr", buf.references, opt)
	map({ "n", "v" }, "<leader>ca", function()
		buf.code_action({
			context = {
				only = { "quickfix", "refactor", "source" },
			},
		})
	end, { noremap = true, silent = true, desc = "code_action" })

	map("n", "ge", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { noremap = true, desc = "goto next error" })
	map("n", "gE", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { noremap = true, desc = "goto previous error" })
end
return M
