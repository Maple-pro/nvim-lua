local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

local servers = {
    bashls,
    clangd,
    cssls,
    emmet_ls,
    gopls,
    html,
    jsonls,
    lua_ls,
    pyright,
    rust_analyzer,
    ts_ls,
    yamlls,
}

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

-- 全局 LSP 附加功能：快捷键、自动命令、功能配置
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- 你的原有快捷键函数（完全兼容你现有的 keybindings.lua）
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- 统一加载 LSP 快捷键
    require("keybindings").mapLSP(buf_set_keymap)
  end,
})

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

