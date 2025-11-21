return {
  "stevearc/conform.nvim",
  lazy = false, -- 立即加载（或按需设置触发时机）
  opts = {
    -- 全局配置
    format_on_save = {
      -- 保存时格式化：超时时间 500ms，未找到工具时不报错
      timeout_ms = 500,
      lsp_fallback = true, -- 找不到格式化工具时，降级使用 LSP 格式化
    },
    -- 按文件类型配置格式化工具（优先级：工具列表从左到右）
    formatters_by_ft = {
      -- 前端文件：先 eslint 修复语法，再 prettier 格式化
      javascript = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      -- Python：black
      python = { "black" },
      -- Lua：stylua
      lua = { "stylua" },
      -- Go：gofmt
      go = { "gofmt", "goimports" }, -- goimports 自动整理导入
      -- Rust：rustfmt
      rust = { "rustfmt" },
      -- 其他文件类型（默认使用 LSP 格式化）
      ["*"] = { "trim_whitespace" }, -- 所有文件自动去除行尾空格
    },
    -- 自定义工具参数（按需配置）
    formatters = {
      prettier = {
        extra_args = { "--single-quote", "--tab-width", "2" },
      },
      black = {
        extra_args = { "--line-length", "120" },
      },
    },
  },
  -- 可选：添加快捷键
  keys = {
    {
      "<M-F>", --手动格式化
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "手动格式化文件",
    },
  },
}
