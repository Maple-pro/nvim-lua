return {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}
