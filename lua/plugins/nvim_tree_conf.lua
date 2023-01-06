-- nvim-tree config

require('nvim-tree').setup({
	view = {
		side = 'right',
		mappings = {
			list = {
				{key = 'C', action = 'cd'},
				{key = 'X', action = 'toggle_git_clean'}
			},
		}
	},
	renderer = {
		git = {
			unstaged = '',
		},
	},
})
