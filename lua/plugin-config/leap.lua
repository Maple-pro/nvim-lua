local status, leap = pcall(require, "leap")
if not status then
  vim.notify("没有找到 leap")
  return
end

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>s', '<Plug>(leap)')
vim.keymap.set('n',               '<leader>S', '<Plug>(leap-from-window)')
