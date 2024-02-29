-- Telescope configuration

local telescope = require('telescope')

telescope.setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
}
pcall(telescope.load_extension, 'fzf') -- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'remote-sshfs') -- Enable telescope remote-sshfs, if installed
