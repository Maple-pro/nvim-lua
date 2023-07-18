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
