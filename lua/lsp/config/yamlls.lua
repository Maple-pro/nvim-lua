local opts = {
    settings = {
        yaml = {
            format = {
                enable = true,
            },
            schemas = {
                ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] =
                "conf/**/*catalog*",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
        },
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    flags = {
        debounce_text_changes = 150,
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
