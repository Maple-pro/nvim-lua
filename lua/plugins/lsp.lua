return {
  "neovim/nvim-lspconfig",
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = false,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  {
    "hrsh7th/vim-vsnip",
    config = function()
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/custom_snippets"
    end,
  },
  "hrsh7th/cmp-vsnip",
  "rafamadriz/friendly-snippets",

  "onsails/lspkind-nvim",
  "nvimdev/lspsaga.nvim",

  "nvimtools/none-ls.nvim",
  "b0o/schemastore.nvim",
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    version = "^9",
  },
}
