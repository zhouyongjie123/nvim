return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "catppuccin",
			always_divide_middle = false,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				"filename",
				{
					function()
						local deco = vim.g.flutter_tools_decorations or {}
						local parts = {}
						if deco.app_version then
							table.insert(parts, "v" .. deco.app_version)
						end
						if deco.device then
							table.insert(parts, deco.device)
						end
						if deco.project_config then
							table.insert(parts, "[" .. deco.project_config .. "]")
						end
						return #parts > 0 and " " .. table.concat(parts, " | ") or ""
					end,
					cond = function()
						return vim.bo.filetype == "dart"
					end,
				},
			},
			lualine_x = { "lsp_status" },
			lualine_y = { "encoding", "fileformat", "filetype", "progress" },
			lualine_z = { "locatgion" },
		},
		-- winbar = {
		-- 	lualine_a = {
		-- 		"filename",
		-- 	},
		-- 	lualine_b = {
		-- 		{
		-- 			function()
		-- 				return ""
		-- 			end,
		-- 			color = "Comment",
		-- 		},
		-- 	},
		-- 	lualine_x = {
		-- 		"lsp_status",
		-- 	},
		-- },
		inactive_winbar = {
			lualine_b = {
				function()
					return " "
				end,
			},
		},
	},
	config = function(_, opts)
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		local function show_macro_recording()
			local recording_register = vim.fn.reg_recording()
			if recording_register == "" then
				return ""
			else
				return "󰑋 " .. recording_register
			end
		end
		local macro_recording = {
			show_macro_recording,
			color = { fg = "#333333", bg = mocha.red },
			separator = {
				left = "",
				right = "",
			},
			padding = 0,
		}
		table.insert(opts.sections.lualine_x, 1, macro_recording)
		require("lualine").setup(opts)
	end,
}
