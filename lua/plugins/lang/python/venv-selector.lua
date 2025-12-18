return {
	"linux-cultist/venv-selector.nvim",
	cmd = "VenvSelect",
	opts = {
		settings = {
			options = {
				notify_user_on_venv_activation = true,
			},
		},
	},
	--  Call config for python files and load the cached venv automatically
	ft = "python",
	keys = { { "<leader>cv", "<CMD>VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" } },
}
