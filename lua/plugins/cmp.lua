-- 放在 ~/.config/nvim/lua/plugins/cmp.lua（或 plugins/init.lua 中）
return {
	-- 核心补全框架
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" }, -- 插入模式 + 命令行模式触发
		dependencies = {
			-- 补全源（必选）
			"hrsh7th/cmp-cmdline", -- 命令行补全
			"hrsh7th/cmp-path", -- 路径补全
			"hrsh7th/cmp-nvim-lsp", -- LSP 语法补全
			-- 补全源（推荐）
			"hrsh7th/cmp-buffer", -- 缓冲区补全
			"hrsh7th/cmp-nvim-lua", -- Lua API 补全
			-- 代码片段（推荐）
			"L3MON4D3/LuaSnip", -- 代码片段引擎
			"saadparwaiz1/cmp_luasnip", -- 联动 nvim-cmp 和 LuaSnip
			-- 可选：图标支持
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local icons = require("nvim-web-devicons") -- 图标支持（可选）

			-- 配置代码片段触发键（可选，如 Tab 展开片段）
			luasnip.config.setup({
				history = true, -- 记住上次展开的片段
				updateevents = "TextChanged,TextChangedI", -- 文本变化时更新片段
			})

			-- 核心补全配置
			cmp.setup({
				-- 代码片段支持
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- 用 LuaSnip 展开片段
					end,
				},

				-- 快捷键配置（和 blink.cmp 习惯对齐，可自定义）
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping(function(fallback)
						-- 如果有补全菜单，选中下一个
						if cmp.visible() then
							cmp.select_next_item()
						-- 如果有可展开的片段，展开
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						-- 否则触发默认 Tab 行为
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item() -- 选中上一个补全项
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1) -- 回退片段
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping.confirm({
						select = true, -- 自动选中第一个补全项（无需手动按 Tab）
						behavior = cmp.ConfirmBehavior.Replace, -- 替换光标后的文本
					}),

					["<C-e>"] = cmp.mapping.abort(), -- 取消补全（Ctrl+E）
					["<C-u>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动补全文档
					["<C-d>"] = cmp.mapping.scroll_docs(4), -- 向下滚动补全文档
				}),

				-- 补全源优先级（先 LSP → 片段 → 路径 → 缓冲区 → Lua API）
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP 语法补全（最高优先级）
					{ name = "luasnip" }, -- 代码片段补全
					{ name = "path" }, -- 路径补全
					{ name = "buffer" }, -- 缓冲区补全（当前文件）
					{ name = "nvim_lua" }, -- Lua API 补全（配置文件用）
				}),

				-- 补全菜单美化（可选，提升视觉体验）
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded", -- 圆角边框
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,Search:None",
					}),
					documentation = cmp.config.window.bordered({ border = "rounded" }), -- 补全文档边框
				},

				-- 补全项格式（显示图标 + 类型 + 来源）
				formatting = {
					fields = { "kind", "abbr", "menu" }, -- 显示顺序：类型图标 → 补全文本 → 来源
					format = function(entry, item)
						-- 为补全项添加图标（基于文件类型/补全类型）
						if item.kind == "File" then
							item.kind = icons.get_icon(item.abbr) or "󰈙"
						else
							-- 补全类型图标（如函数、变量、类等）
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
							luasnip = "[片段]",
							buffer = "[缓冲区]",
							path = "[路径]",
							nvim_lua = "[NVim]",
						})[entry.source.name]

						return item
					end,
				},

				-- 其他优化配置
				experimental = { ghost_text = true }, -- 幽灵文本（灰色显示完整补全建议）
				sorting = {
					comparators = {
						cmp.config.compare.offset, -- 按偏移量排序
						cmp.config.compare.exact, -- 精确匹配优先
						cmp.config.compare.score, -- 按分数排序
						cmp.config.compare.kind, -- 按类型排序
					},
				},
			})

			-- ##############################
			-- 命令行模式补全配置（关键！）
			-- ##############################
			-- 1. : 命令行补全（如 :TSUpdate、:e 文件名）
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "path" }, -- 路径补全（如 :e 补全文件路径）
					{ name = "cmdline" }, -- 命令补全（如 :TS 补全 :TSUpdate）
				}),
			})

			-- 2. / ? 搜索模式补全（搜索时补全缓冲区文本）
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
		end,
	},

	-- 可选：安装常用代码片段（如 Lua、Python、JS 等）
	{
		"rafamadriz/friendly-snippets",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load() -- 加载 vscode 风格片段
		end,
	},
}
