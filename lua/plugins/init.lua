-- Bootstrap lazy.vnim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({'git', 'clone', '--filter=blob:none', '--single-branch', 'https://github.com/folke/lazy.nvim.git', lazypath})
end
vim.opt.runtimepath:prepend(lazypath)

-- Sewt the leader key before lazy so the mappings work correctly (apparently... see lazy.nvim docs)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
	{
		'catppuccin/nvim',
		name = 'catppuccin'
	},
	{
		'Nexmean/caskey.nvim',
		name = 'caskey',
		dependencies = {'folke/which-key.nvim'}
	}
})

-- Extra configurations
require('caskey.wk').setup(require('plugins/caskey_conf'))
