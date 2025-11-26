return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-cmdline", -- 命令行补全
			"hrsh7th/cmp-path", -- 路径补全
			"hrsh7th/cmp-nvim-lsp", -- LSP 语法补全
			"hrsh7th/cmp-buffer", -- 缓冲区补全
			"hrsh7th/cmp-nvim-lua", -- Lua API 补全
			"L3MON4D3/LuaSnip", -- 代码片段引擎
			"saadparwaiz1/cmp_luasnip", -- 联动 nvim-cmp 和 LuaSnip
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local icons = require("nvim-web-devicons")
			luasnip.config.setup({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-- 快捷键
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1) -- 回退片段
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({
								select = true,
								behavior = cmp.ConfirmBehavior.Replace,
							})
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-e>"] = cmp.mapping.abort(), -- 取消补全（Ctrl+E）
					["<C-u>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动补全文档
					["<C-d>"] = cmp.mapping.scroll_docs(4), -- 向下滚动补全文档
				}),

				-- 补全源优先级（先 LSP → 片段 → 路径 → 缓冲区 → Lua API）
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
				}),

				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,Search:None",
					}),
					documentation = cmp.config.window.bordered({ border = "rounded" }),
				},

				-- 补全项格式（显示图标 + 类型 + 来源）
				formatting = {
					fields = { "kind", "abbr", "menu" }, -- 显示顺序：类型图标 → 补全文本 → 来源
					format = function(entry, item)
						if item.kind == "File" then
							item.kind = icons.get_icon(item.abbr) or "󰈙"
						else
							local kind_icons = {
								Text = "",
								Method = "󰆧",
								Function = "󰊕",
								Constructor = "",
								Field = "󰇽",
								Variable = "󰂡",
								Class = "󰠱",
								Interface = "",
								Module = "",
								Property = "󰜢",
								Unit = "",
								Value = "󰎠",
								Enum = "",
								Keyword = "󰌋",
								Snippet = "",
								Color = "󰏘",
								Reference = "",
								Folder = "󰉋",
								EnumMember = "",
								Constant = "󰏿",
								Struct = "",
								Event = "",
								Operator = "󰆕",
								TypeParameter = "󰅲",
							}
							-- item.kind = string.format("%s %s", kind_icons[item.kind], item.kind)
							item.kind = string.format("%s", kind_icons[item.kind])
						end

						-- 显示补全项来源（如 LSP、缓冲区、路径等）
						item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Clip]",
							buffer = "[Buffer]",
							path = "[Path]",
							nvim_lua = "[NVim]",
						})[entry.source.name]

						return item
					end,
				},

				-- 其他优化配置
				experimental = { ghost_text = true }, -- 幽灵文本（灰色显示完整补全建议）
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.kind,
					},
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({
								select = true,
								behavior = cmp.ConfirmBehavior.Replace,
							})
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "c" }),
				}),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
		end,
	},

	{
		"rafamadriz/friendly-snippets",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load() -- 加载 vscode 风格片段
		end,
	},
}
