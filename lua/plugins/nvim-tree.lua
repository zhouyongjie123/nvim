return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        -- 显示 git 状态图标
        git = {
          enable = true,
        },
        -- project plugin 需要这样设置
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        -- 隐藏 .文件 和 node_modules 文件夹
        filters = {
          dotfiles = true,
          custom = { "node_modules" },
        },
        view = {
          -- 宽度
          width = 40,
          -- 也可以 'right'
          side = "left",
          -- 不显示行数
          number = false,
          relativenumber = false,
          -- 显示图标
          signcolumn = "yes",
        },
        actions = {
          open_file = {
            -- 首次打开大小适配
            resize_window = true,
            -- 打开文件时关闭
            quit_on_open = true,
          },
        },
        -- wsl install -g wsl-open
        -- https://github.com/4U6U57/wsl-open/
        system_open = {
          cmd = "wsl-open", -- mac 直接设置为 open
        },
      })
    end,
  },
}
