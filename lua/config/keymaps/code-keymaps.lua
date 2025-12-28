local buf = vim.lsp.buf
local M = {}
M.setup = function(map, opt)
	map("n", "<leader>sh", buf.hover, opt)

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
