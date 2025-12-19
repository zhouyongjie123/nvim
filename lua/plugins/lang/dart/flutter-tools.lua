return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	opts = {
		ui = {
			border = "rounded",
			notification_style = "plugin",
		},
		decorations = {
			statusline = {
				app_version = true,
				device = true,
				project_config = true,
			},
		},
		debugger = {
			enabled = true,
			exception_breakpoints = {},
			evaluate_to_string_in_debug_views = true,
		},
	},
	config = function(_, opts)
		local flutter = require("flutter-tools")
		flutter.setup(opts)
		flutter.setup_project({
			{
				name = "Web",
				device = "chrome",
				flavor = "WebApp",
				web_port = "4000",
				additional_args = { "--wasm" },
			},
			{
				name = "Development", -- an arbitrary name that you provide so you can recognise this config
				flavor = "DevFlavor", -- your flavour
				target = "lib/main_dev.dart", -- your target
				cwd = "example", -- the working directory for the project. Optional, defaults to the LSP root directory.
				device = "pixel6pro", -- the device ID, which you can get by running `flutter devices`
				dart_define = {
					API_URL = "https://dev.example.com/api",
					IS_DEV = true,
				},
				pre_run_callback = nil, -- optional callback to run before the configuration
				-- exposes a table containing name, target, flavor and device in the arguments
				dart_define_from_file = "config.json", -- the path to a JSON configuration file
			},
			{
				name = "Profile",
				flutter_mode = "profile", -- possible values: `debug`, `profile` or `release`, defaults to `debug`
			},
		})
	end,
}
