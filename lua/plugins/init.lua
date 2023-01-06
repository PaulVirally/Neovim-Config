-- LSP configuration

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
	-- Colorscheme
	{
		'catppuccin/nvim',
		name = 'catppuccin'
	},

	-- Keymaps
	{
		'Nexmean/caskey.nvim',
		name = 'caskey',
		dependencies = {'folke/which-key.nvim'}
	},

	-- LSP
	{
		'neovim/nvim-lspconfig',
		name = 'LSP config',
		dependencies = {
			-- Automatically install LSPs with mason
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			-- Eye candy status update
			'j-hui/fidget.nvim',

			-- Additional lua configuration, makes nvim stuff amazing
			'folke/neodev.nvim',
		},
		lazy = true
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip'
		},
		lazy = true
	},

	-- Copilot
	'github/copilot.vim',

	-- Telescope (fuzzy finder)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{'nvim-telescope/telescope-fzy-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1},
			{'nvim-telescope/telescope-frecency.nvim', dependencies = {'kkharji/sqlite.lua', 'nvim-tree/nvim-web-devicons'}},
		},
		lazy = true
	},

	-- Git
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	{'lewis6991/gitsigns.nvim', lazy = true},

	-- More text objects
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			build = function()
				pcall(require('nvim-treesitter.install').update({with_sync = true}))
			end
		},
	},

	-- Comments
	'terrortylor/nvim-comment',
	
	-- Indent guides
	'lukas-reineke/indent-blankline.nvim',
})

-- Finalize configurations TODO: Put these in the config of each plugin?
require('plugins/caskey_conf')
require('plugins/lsp_conf')
require('gitsigns').setup()
require('plugins/treesitter_conf')
require('plugins/copilot_conf')
require('plugins/cmp_conf')
require('plugins/indent_blankline_conf')
