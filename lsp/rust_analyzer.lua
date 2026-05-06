return {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
