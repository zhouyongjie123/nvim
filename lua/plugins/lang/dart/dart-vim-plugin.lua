return {
	"dart-lang/dart-vim-plugin",
	ft = "dart",
	config = function()
		vim.g.dart_format_on_save = 1
		vim.g.dart_html_in_string = 1
		vim.g.dart_style_guide = 2
	end,
}
