return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- 手动初始化 bufferline
		require("lualine").setup({})
	end,
}
