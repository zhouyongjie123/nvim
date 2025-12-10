return {
	"nvim-telescope/telescope-fzf-native.nvim",
	build = function()
		local build_cmd = vim.fn.has("win32") == 1 and "cmake" or nil
		if build_cmd == "cmake" then
			return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
		else
			return "make"
		end
	end,
	enabled = true,
	config = function(_, opts)
		-- 等待telescope.nvim加载完成后再加载扩展
		local telescope_loaded, _ = pcall(require, "telescope")
		if telescope_loaded then
			local ok, err = pcall(require("telescope").load_extension, "fzf")
			if not ok then
				-- 检查编译产物是否存在
				local lib_path = vim.fn.stdpath("data")
					.. "/lazy/telescope-fzf-native.nvim/build/libfzf."
					.. (vim.fn.has("win32") == 1 and "dll" or "so")
				if not vim.loop.fs_stat(lib_path) then
					vim.notify("`telescope-fzf-native.nvim` 未编译，正在重新编译...", vim.log.levels.WARN)
					-- 重新触发编译（Lazy.nvim内置build功能）
					require("lazy").build({ plugins = { "telescope-fzf-native.nvim" }, show = false })
					vim.notify("编译完成，请重启Neovim", vim.log.levels.INFO)
				else
					vim.notify("加载 `telescope-fzf-native.nvim` 失败:\n" .. err, vim.log.levels.ERROR)
				end
			end
		else
			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopeLoaded",
				once = true,
				callback = function()
					require("telescope").load_extension("fzf")
				end,
			})
		end
	end,
}
