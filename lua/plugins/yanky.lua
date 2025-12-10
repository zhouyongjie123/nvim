return {
	"gbprod/yanky.nvim",
	-- recommended = true,
	desc = "Better Yank/Paste",
	-- event = "VeryLazy",
	opts = function()
		local yanky = require("yanky")
		yanky.setup({
			system_clipboard = {
				sync_with_ring = not vim.env.SSH_CONNECTION,
			},
			highlight = { timer = 150 },
			picker = {
				select = {
					action = nil, -- nil to use default put action
				},
			},
		})
	end,
	-- keys = {
	-- 	{
	-- 		"<leader>p",
	-- 		function()
	-- 			-- 优先检查是否安装了telescope.nvim
	-- 			local has_telescope, _ = pcall(require, "telescope")
	-- 			if has_telescope then
	-- 				require("telescope").extensions.yank_history.yank_history()
	-- 				-- -- 可选：若安装了snacks.nvim（非必须）
	-- 			elseif pcall(require, "snacks") then
	-- 				require("snacks").picker.yanky()
	-- 				-- 兜底使用默认的Yanky历史菜单
	-- 			else
	-- 				vim.cmd([[YankyRingHistory]])
	-- 			end
	-- 		end,
	-- 		mode = { "n", "x" },
	-- 		desc = "Open Yank History",
	-- 	},
	-- },
}
