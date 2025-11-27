return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.1.9",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	opts = {
		defaults = {
			path_display = {
				"tail",
			},
			mappings = {
				i = {
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<C-k>"] = require("telescope.actions").move_selection_previous,
				},
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					layout_config = {
						width = 0.8,
						height = 0.4,
					},
					previewer = false,
					prompt_title = false,
				}),
				input = {
					theme = "dropdown", -- dropdown/ivy/cursor
					-- prompt_prefix = "请输入",
					enable_history = true,
					history_path = vim.fn.stdpath("state") .. "/telescope-ui-select-history.txt",
				},
			},
		},
		pickers = {
			lsp_code_actions = {
				theme = "cursor",
				layout_config = {
					width = 0.8,
					height = 0.4,
				},
			},
			lsp_implementations = {
				path_display = { "tail" },
			},
			find_files = {
				hidden = true,
			},
			live_grep = {
				additional_args = { "--hidden" },
			},
		},
	},

	config = function(_, opts)
		local function has_flash()
			local plugin_path = vim.fn.stdpath("data") .. "/lazy/flash.nvim" -- Lazy.nvim默认路径
			return vim.fn.isdirectory(plugin_path) == 1
		end

		-- 替换原有的 LazyVim.has("flash.nvim")
		if not has_flash() then
			return
		end
		local function flash(prompt_bufnr)
			require("flash").jump({
				pattern = "^",
				label = { after = { 0, 0 } },
				search = {
					mode = "search",
					exclude = {
						function(win)
							return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
						end,
					},
				},
				action = function(match)
					local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
					picker:set_selection(match.pos[1] - 1)
				end,
			})
		end
		opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
			mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
		})
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("ui-select")
		local set = vim.keymap.set
		local builtin = require("telescope.builtin")
		set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		-- 映射快捷键
		vim.keymap.set("n", "gi", function()
			require("telescope.builtin").lsp_implementations()
		end)
	end,
}
