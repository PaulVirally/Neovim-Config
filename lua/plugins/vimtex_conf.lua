-- Vimtex config

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk = {
	options = {
		'-pdf',
		'-shell-escape',
		'-verbose',
		'-file-line-error',
		'-synctex=1',
		'-interaction=nonstopmode',
	},
}
