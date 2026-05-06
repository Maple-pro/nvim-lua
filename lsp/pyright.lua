return {
  flags = {
    debounce_text_changes = 150,
  },
  single_file_support = true,
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
      venvPath = "~/.conda/env",
    }
  },
}
