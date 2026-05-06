local status, treesitter = pcall(require, "nvim-treesitter")
if not status then
  vim.notify("没有找到 nvim-treesitter")
  return
end

treesitter.setup{
  -- ensure_installed = "maintained",
  sync_install = false,
  auto_install = false,

  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
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

