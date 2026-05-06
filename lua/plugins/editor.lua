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
  "ur4ltz/surround.nvim",

  {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugin-config.gitsigns") end,
  },

  {
    "akinsho/toggleterm.nvim",
    config = function() require("plugin-config.toggleterm") end,
  },
}