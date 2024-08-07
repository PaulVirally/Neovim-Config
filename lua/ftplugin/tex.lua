vim.cmd('set ft=latex')
require('luasnip').setup({
	enable_autosnippets = true,
})
vim.opt.wrap = true -- Wrap lines in LaTeX
vim.api.nvim_set_option_value('commentstring', '% %s', {}) -- Set commentstring to LaTeX comment
