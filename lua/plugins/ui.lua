return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function() require("plugin-config.nvim-tree") end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function() require("plugin-config.bufferline") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("plugin-config.lualine") end,
  },
  {
    "rcarriga/nvim-notify",
    config = function() require("plugin-config.nvim-notify") end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
  },
  {
    "navarasu/onedark.nvim",
  },
}