local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

local servers = {
    "bashls",
    "clangd",
    "cssls",
    "emmet_ls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "ts_ls",
    "yamlls",
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_enable = {
    exclude = { "rust_analyzer" },
  },
})

-- 全局 LSP 附加功能：快捷键、自动命令、功能配置
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local function mapbuf(mode, lhs, rhs, opts)
      opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- 统一加载 LSP 快捷键
    require("keybindings").mapLSP(mapbuf)
  end,
})
