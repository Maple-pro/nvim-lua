-- vim.g.vimtex_compiler_method = "latexrun"
vim.g.vimtex_compiler_latexmk_engines = {
    _ = "-xelatex"
}
vim.g.vimtex_compiler_latexrun_engines = {
    _ = "-xelatex"
}
-- Disable imaps (using Ultisnips)
vim.g.vimtex_imaps_enabled = 0
vim.g.tex_comment_nospell = 1
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_general_viewer = "okular"
-- vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]
vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
vim.g.Tex_MultipleCompileFormats = "pdf,bib,pdf,pdf"

-- vim.o.conceallevel = 1
-- vim.g.tex_conceal = "abdmg"

