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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)

require("lspconfig.ui.windows").default_options.border = "single"

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
    use_saga_diagnostic_sign = false,
    diagnostic = "Dia",
    code_action = "CA",
  },
  lightbulb = {
    enable = false,
  },
  debug = false,
  use_saga_diagnostic_sign = false,
  -- diagnostic sign
  error_sign = "E",
  warn_sign = "W",
  hint_sign = "H",
  infor_sign = "I",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action = "A",
  code_action_icon = "A",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    -- open = "o",
    open = "<CR>",
    vsplit = "s",
    split = "i",
    -- quit = "q",
    quit = "<ESC>",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    -- quit = "q",
    quit = "<ESC>",
    exec = "<CR>",
  },
  rename_action_keys = {
    -- quit = "<C-c>",
    quit = "<ESC>",
    exec = "<CR>",
  },
  -- definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
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
