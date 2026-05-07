return {
  {
    "nvim-telescope/telescope.nvim",
    config = function() require("plugin-config.telescope") end,
  },
  "LinArcX/telescope-env.nvim",
  "nvim-telescope/telescope-ui-select.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function() require("plugin-config.nvim-treesitter") end,
  },

  {
    "numToStr/Comment.nvim",
    config = function() require("plugin-config.comment") end,
  },

  "windwp/nvim-autopairs",

  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugin-config.gitsigns") end,
  },

  {
    "akinsho/toggleterm.nvim",
    config = function() require("plugin-config.toggleterm") end,
  },

  {
    "https://codeberg.org/andyg/leap.nvim.git",
    lazy = false,
    config = function() require("plugin-config.leap") end,
  },
}
