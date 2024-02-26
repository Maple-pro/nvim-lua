local status, hop = pcall(require, "hop")
if not status then
    vim.notify("没有找到 hop")
    return
end

hop.setup({
    keys = 'etovxqpdygfblzhckisuran'
})

local directions = require("hop.hint").HintDirection

vim.keymap.set('n', '<leader>s', function()
    hop.hint_char1({ direction = nil, current_line_only = false})
end, {remap=true})

vim.keymap.set('n', '<leader><leader>s', function()
    hop.hint_char2({ direction = nil, current_line_only = false})
end, {remap=true})

vim.keymap.set('n', '<leader>f', function ()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('n', '<leader>j', function ()
    hop.hint_lines({ direction = directions.AFTER_CURSOR })
end, {remap=true})

vim.keymap.set('n', '<leader>k', function ()
    hop.hint_lines({ direction = directions.BEFORE_CURSOR })
end, {remap=true})
