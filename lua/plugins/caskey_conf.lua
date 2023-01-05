-- Caskey configuration
-- Most of the keymaps are defined in this file, but some are defined in plugins/lsp_conf.lua

local ck = require('caskey')

require('nvim_comment').setup()
local config = {
	-- All normal move + visual mode + insert move remaps
	{
		mode = {'n', 'x', 'i'},

		-- Save with command + s
		['<D-s>'] = {act = ck.cmd('w'), desc = 'Save file'},
	},

	-- All normal mode + visual mode remaps
	{
		mode = {'n', 'x'},

		-- Leader key is space, so space has to be a no-op
		['<Space>'] = {act = '<NOP>', desc = 'Leader'},

		-- More intuitive line movement
		['j'] = {act = 'gj', desc = 'Move down one line'},
		['k'] = {act = 'gk', desc = 'Move up one line'},

		-- Center cursor when searching
		['n'] = {act = 'nzz', desc = 'Go to next'},
		['N'] = {act = 'Nzz', desc = 'Go to previous'},
	},

	-- All insert mode + cmdline mode remaps
	{
		mode = {'i', 'c'},

		-- Paste with command + v
		['<D-v>'] = {act = '<C-r>+', desc = 'Paste'},
	},

	-- All normal mode remaps
	{
		mode = 'n',

		-- Comment
		['<D-/>'] = {act = ck.cmd('CommentToggle'), desc = 'Toggle comment'},

		-- No highlight when we press escape
		['<Esc>'] = {act = ck.cmd('noh'), desc = 'Remove highlight', mode = 'n'},

		-- Correct spelling mistakes
		['<Leader>ss'] = {act = 'ms[s1z=`s', desc = 'Correct previous spelling mistake'},
		['<Leader>sS'] = {act = 'ms]s1z=`s', desc = 'Correct next spelling mistake'},

		-- More intuitive line yanking
		['Y'] = {act = 'yy', desc = 'Copy entire line'},

		-- Move from window to window
		['<C-h>'] = {act = '<C-w>h', desc = 'Move to the left window'},
		['<C-j>'] = {act = '<C-w>j', desc = 'Move to the bottom window'},
		['<C-k>'] = {act = '<C-w>k', desc = 'Move to the top window'},
		['<C-l>'] = {act = '<C-w>l', desc = 'Move to the right window'},

		-- Telescope
		['<Leader>?'] = {act = require('telescope.builtin').oldfiles, desc = '[?] Find recently opened files'},
		['<Leader><Space>'] = {act = require('telescope.builtin').buffers, desc = '[ ] Find existing buffers'},
		['<Leader>/'] = {act = function()
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, desc = '[/] Fuzzily search in current buffer]'},
		['<Leader>sf'] = {act = require('telescope').extensions.frecency.frecency, desc = '[S]earch [F]iles'},
		['<Leader>sh'] = {act = require('telescope.builtin').help_tags, desc = '[S]earch [H]elp'},
		['<Leader>sw'] = {act = require('telescope.builtin').grep_string, desc = '[S]earch current [W]ord'},
		['<Leader>sg'] = {act = require('telescope.builtin').live_grep, desc = '[S]earch by [G]rep'},
		['<Leader>sd'] = {act = require('telescope.builtin').diagnostics, desc = '[S]earch [D]iagnostics'},

		-- Diagnostics
		['[d'] = {act = vim.diagnostic.goto_prev, desc = 'Go to previous diagnostic'},
		[']d'] = {act = vim.diagnostic.goto_next, desc = 'Go to next diagnostic'},
		['<Leader>e'] = {act = vim.diagnostic.open_float, desc = 'Show all diagnostics'},
		['<Leader>q'] = {act = vim.diagnostic.set_loclist, desc = 'Show all diagnostics in loclist'},
	},

	-- All visual mode remaps
	{
		mode = 'x',

		-- Indent
		['>'] = {act = '>gv', desc = 'Indent'},
		['<'] = {act = '<gv', desc = 'Un-indent'},

		-- Move lines
		['J'] = {act = ':move \'>+1<CR>gv-gv', desc = 'Move line down'},
		['K'] = {act = ':move \'<-2<CR>gv-gv', desc = 'Move line up'},

		-- Comment
		['<D-/>'] = {act = ":'<,'>CommentToggle<CR>gv", desc = 'Toggle comment selection'},
	},
}


require('caskey.wk').setup(config)
