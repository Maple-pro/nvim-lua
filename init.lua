-- 基础配置
require("basic")
-- 快捷键映射
require("keybindings")
-- Packer插件管理
require("plugins")
-- 主题设置
require("colorscheme")
-- 自动命令
require("autocmds")
-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.lualine")
require("plugin-config.bufferline")
-- require("plugin-config.dashboard")
require("plugin-config.telescope")
require("plugin-config.comment")
require("plugin-config.nvim-treesitter")
-- require("plugin-config.vimtex")
-- 内置LSP
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")

