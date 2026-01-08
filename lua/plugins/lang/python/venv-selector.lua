return {
	"linux-cultist/venv-selector.nvim",
	cmd = "VenvSelect",
	opts = {
		options = {
			notify_user_on_venv_activation = true,
		},
		search_venv_managers = true, -- 只保留venv，关闭poetry/pipenv等
		search_workspace = true, -- 搜索当前项目目录
		search_paths = { "~/.virtualenvs", "./venv", "./.venv" }, -- venv查找路径
		auto_refresh = true,
	},
	--  Call config for python files and load the cached venv automatically
	ft = "python",
	-- keys = { { "<leader>cv", "<CMD>VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" } },
	config = function(_, opts)
		local venv_selector = require("venv-selector")
		venv_selector.setup(opts)
		vim.api.nvim_create_user_command("Env", function(args)
			vim.cmd("VenvSelect")
		end, { desc = "Select VirtualEnv" })
	end,
}
