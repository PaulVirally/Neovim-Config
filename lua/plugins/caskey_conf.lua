local ck = require('caskey')

return {
	-- All normal move + visual mode + insert move remaps
	{
		mode = {'n', 'v', 'i'},

		-- Save with command + s
		['<D-s>'] = {act = ck.cmd('w'), desc = 'Save file'},
	},

	-- All nrmal mode + visual mode remaps
	{
		mode = {'n', 'v'},

		-- Leader key is space, so space has to be a no-op
		['<Space>'] = {act = '<NOP>', desc = 'Leader'},

		-- More intuitive line movement
		['j'] = {act = 'gj', desc = 'Move down one line'},
		['k'] = {act = 'gk', desc = 'Move up one line'},

		-- Center cursor when searching
		['n'] = {act = 'nzz', desc = 'Go to next'},
		['N'] = {act = 'Nzz', desc = 'Go to previous'},
	},

	-- All normal mode remaps
	{
		mode = 'n',

		-- No highlight when we press escape
		['<Esc>'] = {act = ck.cmd('noh'), desc = 'Remove highlight', mode = 'n'},

		-- Correct spelling mistakes
		['<Leader>s'] = {act = 'ms[s1z=`s', desc = 'Correct previous spelling mistake'},
		['<Leader>S'] = {act = 'ms]s1z=`s', desc = 'Correct next spelling mistake'},

		-- More intuitive line yanking
		['Y'] = {act = 'yy', desc = 'Copy entire line'},

		-- Move from window to window
		['<C-h>'] = {act = '<C-w>h', desc = 'Move to the left window'},
		['<C-j>'] = {act = '<C-w>j', desc = 'Move to the bottom window'},
		['<C-k>'] = {act = '<C-w>k', desc = 'Move to the top window'},
		['<C-l>'] = {act = '<C-w>l', desc = 'Move to the right window'},
	},

	-- All insert mode remaps
	{
		mode = 'i',

		-- Paste with command  +v
		['<D-v>'] = {act = '<C-r>+', desc = 'Paste'},
	},

	-- All visual mode remaps
	{
		mode = 'v',

		-- Indent
		['>'] = {act = '>gv', desc = 'Indent'},
		['<'] = {act = '<gv', desc = 'Un-indent'},
	},
}
