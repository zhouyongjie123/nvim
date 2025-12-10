return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify",
	},
	opts = {
		presets = {
			inc_rename = true,
		},
		notify = {
			enabled = true,
			view = "notify",
		},

		views = {
			popup = {
				border = "rounded",
				size = {
					width = "80%",
					height = "auto",
				},
				position = "50%",
			},

			cmdline_output = {
				view = "cmdline_output",
				opts = {
					buf_options = { filetype = "noice" },
					position = { row = -1, col = 0 },
					size = { height = "auto" },
					border = { top = true, bottom = false, left = false, right = false },
				},
			},

			hover = {
				border = "rounded",
				size = { width = "90%" },
				position = { row = 2, col = 2 },
			},

			notify = {
				backend = "notify",
				opts = {
					timeout = 5000,
					animate = "slide",
				},
			},
		},

		routes = {
			{
				filter = { event = "lsp", kind = "hover" },
				view = "hover",
			},
			{
				filter = { event = "lsp", kind = "signatureHelp" },
				view = "hover",
				opts = { size = { width = "80%" } },
			},
			{
				filter = { event = "msg_show", kind = "" },
				opts = { skip = true },
			},

			{
				filter = { event = "msg_show", kind = "search_count" },
				opts = { skip = true },
			},
		},

		history = {
			enabled = true,
			view = "popup",
			opts = { size = { height = 10 } },
		},

		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
	},
}
