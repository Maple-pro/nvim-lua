local status, treesitter = pcall(require, "nvim-treesitter")
if not status then
  vim.notify("没有找到 nvim-treesitter")
  return
end

treesitter.setup{
  install_dir = vim.fn.stdpath("data") .. "/site",
}
treesitter.install{
  "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "markdown", "markdown_inline",
  "kotlin", "java", "python", "c", "cpp", "cuda", "dart", "go", "latex", "sql", "vue", "vimdoc"
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua", "vim", "vimdoc",
    "html", "css", "javascript", "typescript", "tsx", "vue",
    "json", "markdown", "markdown_inline",
    "python", "java", "kotlin", "go", "dart",
    "c", "cpp", "cuda", "sql", "latex"
  },
  callback = function()
    vim.treesitter.start()
    -- 开启 Treesitter 折叠
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldlevel = 99

    -- 开启 Treesitter 缩进（实验性）
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
