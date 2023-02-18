-- nvim-tree config

require('nvim-tree').setup({
	view = {
		adaptive_size = true,
		side = 'right',
		mappings = {
			list = {
				{key = 'C', action = 'cd'},
				{key = 'X', action = 'toggle_git_clean'}
			},
		}
	},
	update_focused_file = {
		enable = true,
	},
	modified = {
		enable = true,
	},
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = '',
				},
			},
		},
	},
	-- update_focused_file = {
	-- 	enable = true,
	-- 	update_cwd = true,
	-- },
})

-- Changes vim's working directory to the current file's directory
local cwd_group = vim.api.nvim_create_augroup('CWDOnBufEnter', {clear = true})
vim.api.nvim_create_autocmd('BufEnter', {
	  command = 'silent! lcd %:p:h',
	  group = cwd_group
})
