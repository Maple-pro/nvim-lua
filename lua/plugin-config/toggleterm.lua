local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("没有找到 toggleterm")
  return
end

toggleterm.setup({
  open_mapping = [[<c-\>]],
  direction = 'horizontal',
  shade_terminals = false,
  float_opts = {
    border = 'curved',
  }
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>git", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
