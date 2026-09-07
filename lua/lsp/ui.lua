-- 自定义图标
-- Highlight entire line for errors
-- Highlight the line number for warnings
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
  update_in_insert = false,
})
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl }) // deprecated
-- end

-- 配置 LSP 悬浮窗口边框
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = vim.tbl_extend("force", config or {}, { border = "single" })
  return vim.lsp.handlers.hover(_, result, ctx, config)
end

-- lspkind
local lspkind = require("lspkind")
lspkind.init({
  -- default: true
  -- with_text = true,
  -- defines how annotations are shown
  -- default: symbol
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "text",
})

local lspsaga = require("lspsaga")
lspsaga.setup({ -- defaults ...
  ui = {
    border = "single",
  },
  lightbulb = {
    enable = false,
  },
})

local M = {}
-- 为 cmp.lua 提供参数格式
M.formatting = {
  format = lspkind.cmp_format({
    mode = "symbol_text",
    --mode = 'symbol', -- show only symbol annotations

    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function(entry, vim_item)
      -- Source 显示提示来源
      vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
      return vim_item
    end,
  }),
}

return M
