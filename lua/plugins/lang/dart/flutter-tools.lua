return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	opts = {
		ui = {
			-- the border type to use for all floating windows, the same options/formats
			-- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
			border = "rounded",
			-- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
			-- please note that this option is eventually going to be deprecated and users will need to
			-- depend on plugins like `nvim-notify` instead.
			notification_style = "plugin",
		},
		decorations = {
			statusline = {
				-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
				-- this will show the current version of the flutter app from the pubspec.yaml file
				app_version = true,
				-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
				-- this will show the currently running device if an application was started with a specific
				-- device
				device = true,
				-- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
				-- this will show the currently selected project configuration
				project_config = true,
			},
		},
		debugger = {
			enabled = true,
			-- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
			-- see |:help dap.set_exception_breakpoints()| for more info
			exception_breakpoints = {},
			-- Whether to call toString() on objects in debug views like hovers and the
			-- variables list.
			-- Invoking toString() has a performance cost and may introduce side-effects,
			-- although users may expected this functionality. null is treated like false.
			evaluate_to_string_in_debug_views = true,
			-- You can use the `debugger.register_configurations` to register custom runner configuration (for example for different targets or flavor). Plugin automatically registers the default configuration, but you can override it or add new ones.
			-- register_configurations = function(paths)
			--   require("dap").configurations.dart = {
			--     -- your custom configuration
			--   }
			-- end,
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
