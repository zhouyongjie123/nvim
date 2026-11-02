-- Material Palenight 高亮配色
vim.api.nvim_set_hl(0, "@function", { fg = "#ffcb6b" })
vim.api.nvim_set_hl(0, "@function.call", { link = "@function" })
vim.api.nvim_set_hl(0, "@method", { link = "@function" })
vim.api.nvim_set_hl(0, "@method.call", { link = "@function" })
vim.api.nvim_set_hl(0, "Function", { fg = "#ffcb6b" })

vim.api.nvim_set_hl(0, "@variable", { fg = "#eeffff" })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#f07178", italic = true })
vim.api.nvim_set_hl(0, "@parameter", { link = "@variable" })

vim.api.nvim_set_hl(0, "@type", { fg = "#80cbc4" })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#80cbc4" })
vim.api.nvim_set_hl(0, "Type", { fg = "#80cbc4" })

vim.api.nvim_set_hl(0, "@module", { fg = "#80cbc4" })

vim.api.nvim_set_hl(0, "@field", { fg = "#f78c6c" })
vim.api.nvim_set_hl(0, "@property", { link = "@field" })

vim.api.nvim_set_hl(0, "@constant", { fg = "#c792ea" })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = "#c792ea" })
vim.api.nvim_set_hl(0, "Constant", { fg = "#c792ea" })

vim.api.nvim_set_hl(0, "@keyword", { fg = "#c792ea" })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#c792ea" })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#c792ea" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#c792ea" })

vim.api.nvim_set_hl(0, "@string", { fg = "#c3e88d" })
vim.api.nvim_set_hl(0, "String", { fg = "#c3e88d" })

vim.api.nvim_set_hl(0, "@number", { fg = "#f78c6c" })
vim.api.nvim_set_hl(0, "Number", { fg = "#f78c6c" })

vim.api.nvim_set_hl(0, "@boolean", { fg = "#f78c6c" })

vim.api.nvim_set_hl(0, "@operator", { fg = "#89ddff" })

vim.api.nvim_set_hl(0, "@comment", { fg = "#676e95", italic = true })
vim.api.nvim_set_hl(0, "Comment", { fg = "#676e95", italic = true })

vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#89ddff" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "#89ddff" })

vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#44425f" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#44425f" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#545287" })

vim.api.nvim_set_hl(0, "RainbowDelimiter1", { fg = "#f07178" })
vim.api.nvim_set_hl(0, "RainbowDelimiter2", { fg = "#ffcb6b" })
vim.api.nvim_set_hl(0, "RainbowDelimiter3", { fg = "#82aaff" })
vim.api.nvim_set_hl(0, "RainbowDelimiter4", { fg = "#f78c6c" })
vim.api.nvim_set_hl(0, "RainbowDelimiter5", { fg = "#c3e88d" })
vim.api.nvim_set_hl(0, "RainbowDelimiter6", { fg = "#c792ea" })
vim.api.nvim_set_hl(0, "RainbowDelimiter7", { fg = "#89ddff" })
