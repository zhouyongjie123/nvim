return {
	settings = {
		gopls = {
			-- 语义高亮：由 gopls 判定标识符角色，同一标识符在各处颜色一致
			ui = { semanticTokens = true },
			staticcheck = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
		},
	},
}
