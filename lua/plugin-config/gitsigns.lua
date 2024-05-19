local status, gitsigns = pcall(require, "gitsigns")
if not status then
  vim.notify("Gitsigns plugins not exist")
  return
end

gitsigns.setup {
  on_attach = require("keybindings").gitsigns_on_attach
}
