-- Caskey configuration
-- Most of the keymaps are defined in this file, but some are defined in plugins/lsp_conf.lua

local ck = require('caskey')

require('nvim_comment').setup()
local config = {

	-- All normal mode + visual mode + insert + terminal mode remaps
	{
		mode = {'n', 'x', 'i', 't'},

		-- Save with command + s
		['<D-s>'] = {act = ck.cmd('w'), desc = 'Save file'},

		-- Move around with command + arrow keys
		['<D-Left>'] = {act = ck.cmd('norm! ^'), desc = 'Go to beginning of line'},
		['<D-Right>'] = {act = ck.cmd('norm! $'), desc = 'Go to end of line'},
		['<D-Up>'] = {act = ck.cmd('norm! gg'), desc = 'Go to beginning of file'},
		['<D-Down>'] = {act = ck.cmd('norm! G'), desc = 'Go to end of file'},
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

	-- All insert mode
	{
		mode = {'i'},

		-- Paste with command + v
		['<D-v>'] = {act = '<C-o>gP', desc = 'Paste'},
	},

	-- All cmdline mode remaps
	{
		mode = {'c'},

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
		['<Leader>ss'] = {act = function()
			vim.cmd('norm! ms[s')
			local old_word = vim.fn.expand('<cword>')
			vim.cmd('norm! 1z=')
			local new_word = vim.fn.expand('<cword>')
			vim.cmd('norm! `s')
			print('Changed "' .. old_word .. '" to "' .. new_word .. '"')
		end, desc = 'Correct previous spelling mistake'},
		['<Leader>sS'] = {act = function()
			vim.cmd('norm! ms]s')
			local old_word = vim.fn.expand('<cword>')
			vim.cmd('norm! 1z=')
			local new_word = vim.fn.expand('<cword>')
			vim.cmd('norm! `s')
			print('Changed "' .. old_word .. '" to "' .. new_word .. '"')
		end, desc = 'Correct next spelling mistake'},

		-- More intuitive line yanking
		['Y'] = {act = 'yy', desc = 'Copy entire line'},

		-- Move from window to window
		['<C-h>'] = {act = '<C-w>h', desc = 'Move to the left window'},
		['<C-j>'] = {act = '<C-w>j', desc = 'Move to the bottom window'},
		-- ['<C-k>'] = {act = '<C-w>k', desc = 'Move to the top window'},
		['<C-l>'] = {act = '<C-w>l', desc = 'Move to the right window'},

		-- Telescope
		['<Leader>?'] = {act = require('telescope.builtin').oldfiles, desc = 'Find recently opened files'},
		['<Leader><Space>'] = {act = require('telescope.builtin').buffers, desc = 'Find existing buffers'},
		['<Leader>/'] = {act = function()
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, desc = 'Fuzzy search in current buffer]'},
		['<Leader>sf'] = {act = require('telescope').extensions.frecency.frecency, desc = 'Search files'},
		['<Leader>sh'] = {act = require('telescope.builtin').help_tags, desc = 'Search help'},
		['<Leader>sw'] = {act = require('telescope.builtin').grep_string, desc = 'Search current word'},
		['<Leader>sg'] = {act = require('telescope.builtin').live_grep, desc = 'Search by grep'},
		['<Leader>sd'] = {act = require('telescope.builtin').diagnostics, desc = 'Search diagnostics'},

		-- Diagnostics
		['[d'] = {act = vim.diagnostic.goto_prev, desc = 'Go to previous diagnostic'},
		[']d'] = {act = vim.diagnostic.goto_next, desc = 'Go to next diagnostic'},
		['<Leader>ee'] = {act = ck.cmd('TroubleToggle'), desc = 'Show errors and references'},
		['<Leader>ew'] = {act = ck.cmd('TroubleToggle'), desc = 'Show workspace errors'},
		['<Leader>ed'] = {act = ck.cmd('TroubleToggle'), desc = 'Show document errors'},
		['<Leader>ef'] = {act = ck.cmd('TroubleToggle quickfix'), desc = 'Show error quickfixes'},
		['<Leader>el'] = {act = ck.cmd('TroubleToggle loclist'), desc = 'Show loclist'},
		['gr'] = {act = ck.cmd('TroubleToggle lsp_references'), desc = 'Go to reference'},

		-- Git signs
		['gp'] = {act = ck.cmd('Gitsigns preview_hunk_inline'), desc = 'Preview git diff'},
		['gR'] = {act = ck.cmd('Gitsigns reset_hunk'), desc = 'Restore git hunk'},

		-- Buffer navigation
		['<D-{>'] = {act = ck.cmd('BufferPrevious'), desc = 'Go to previous buffer'},
		['<D-}>'] = {act = ck.cmd('BufferNext'), desc = 'Go to next buffer'},
		['<D-w>'] = {act = ck.cmd('BufferClose'), desc = 'Close buffer'},

		-- File explorer
		['<Leader>t'] = {act = ck.cmd('NvimTreeToggle'), desc = 'Toggle file explorer'},

		-- Restore last session
		['<Leader>qq'] = {act = function()
			vim.cmd('SessionManager save_current_session')
			vim.cmd('SessionManager load_session')
		end, desc = 'Select session to load'},
		['<Leader>ql'] = {act = ck.cmd('SessionManager load_last_session'), desc = 'Load last session'},
		['<Leader>qc'] = {act = ck.cmd('SessionManager load_current_dir_session'), desc = 'Load session for current directory'},

		-- Save current session
		['<Leader>qs'] = {act = ck.cmd('SessionManager save_current_session'), desc = 'Save session'},

		-- Open a terminal
		['<C-`><C-`>'] = {act = ck.cmd('ToggleTerm direction=float'), desc = 'Open a terminal (floating)'},
		['<C-`><C-j>'] = {act = ck.cmd('ToggleTerm direction=horizontal'), desc = 'Open a terminal (below)'},
		['<C-`><C-l>'] = {act = ck.cmd('ToggleTerm direction=vertical dir=' .. tostring(vim.o.columns*0.4)), desc = 'Open a terminal (right)'},

		-- 🦆
		['<Leader>dd'] = {act = function() require('duck').hatch() end, desc = '🦆'},
		['<Leader>dk'] = {act = function() require('duck').cook() end, desc = '🚫🦆'},

		-- Peek
		['<Leader>pd'] = {act = ck.cmd('Glance definitions'), desc = 'Peek definition'},
		['<Leader>pr'] = {act = ck.cmd('Glance references'), desc = 'Peek reference'},
		['<Leader>pt'] = {act = ck.cmd('Glance type-definitions'), desc = 'Peek type definition'},
		['<Leader>pi'] = {act = ck.cmd('Glance implementations'), desc = 'Peek implementation'},

		-- Search word under cursor with ag (silver searcher)
		['<Leader>*'] = {act = function()
			local word = vim.fn.expand('<cword>')
			vim.cmd('Ag ' .. word)
		end, desc = 'Search word under cursor with ag (silver searcher)'},

		-- Open/close folds
		['<Leader>f'] = {act = 'za', desc = 'Toggle fold'},
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

	-- Terminal mode remaps
	{
		mode = 't',

		-- Enter normal mode
		['<esc>'] = {act = '<C-\\><C-n>', desc = 'Exit terminal mode'},

		-- Move between windows
		['<C-h>'] = {act = '<C-\\><C-n><C-w>h', desc = 'Move to the left window'},
		['<C-j>'] = {act = '<C-\\><C-n><C-w>j', desc = 'Move to the bottom window'},
		['<C-k>'] = {act = '<C-\\><C-n><C-w>k', desc = 'Move to the top window'},
		['<C-l>'] = {act = '<C-\\><C-n><C-w>l', desc = 'Move to the right window'},

		-- Close terminal
		['<C-`>'] = {act = ck.cmd('ToggleTerm'), desc = 'Close terminal'},
	}
}


require('caskey.wk').setup(config)
