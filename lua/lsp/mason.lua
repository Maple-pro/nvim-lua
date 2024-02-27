-- Documentation: https://github.com/williamboman/mason-lspconfig.nvim
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Setup mason
mason.setup()

-- Servers table with optional config modules
local servers = {
    bashls = require("lsp.config.bash"),
    clangd = require("lsp.config.clangd"),
    cssls = require("lsp.config.css"),
    emmet_ls = require("lsp.config.emmet"),
    gopls = require("lsp.config.gopls"),
    html = require("lsp.config.html"),
    jsonls = require("lsp.config.json"),
    -- kotlin_language_server = require("lsp.config.kotlin"),
    lua_ls = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
    pyright = require("lsp.config.pyright"),
    remark_ls = require("lsp.config.markdown"),
    rust_analyzer = require("lsp.config.rust"),
    tsserver = require("lsp.config.ts"),
    yamlls = require("lsp.config.yamlls"),
    -- ltex = nil -- language server use default setup handler
}

-- Ensure the servers are installed
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
}

-- Default handler for servers without specific configuations
local function default_handler(server_name)
    lspconfig[server_name].setup {}
end

local function setup_servers()
    for server, config in pairs(servers) do
        if config then
            mason_lspconfig.setup_handlers {
                [server] = function()
                    config.on_setup(lspconfig[server])
                end,
            }
        else
            -- Use the default handler for servers without a specific config module
            mason_lspconfig.setup_handlers {
                [server] = function()
                    default_handler(server)
                end,
            }
        end
    end
end

setup_servers()

