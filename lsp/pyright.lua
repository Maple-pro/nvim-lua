return {
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
      -- pythonPath = "/home/yangfeng/.conda/env/hello/bin/python",
      venvPath = vim.fn.expand("~/.conda/env"),
    },
  },
}
