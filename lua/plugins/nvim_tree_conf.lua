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
})
