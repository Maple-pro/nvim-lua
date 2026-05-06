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
            package_uninstalled = "✗"
        },
    }
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  {
    "hrsh7th/vim-vsnip",
    config = function()
      vim.g.vsnip_snippet_dir = "/home/yangfeng/.config/nvim/custom_snippets"
    end,
  },
  "hrsh7th/cmp-vsnip",
  "rafamadriz/friendly-snippets",

  "onsails/lspkind-nvim",
  "nvimdev/lspsaga.nvim",

  "mhartington/formatter.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "folke/lua-dev.nvim",
  "b0o/schemastore.nvim",
  "simrat39/rust-tools.nvim",
}