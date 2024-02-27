-- Documentation: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-config
-- Example: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/gopls.lua
local opts = {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
    on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        require("keybindings").mapLSP(buf_set_keymap)
    end
}

return {
    on_setup = function(server)
        server.setup(opts)
    end,
}
