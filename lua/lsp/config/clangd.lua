-- Example: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
local opts = {
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


