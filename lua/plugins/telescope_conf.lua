-- Telescope configuration

local telescope = require('telescope')

telescope.setup({
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
	extensions = {
		zoxide = {
			prompt_title = 'Zoxide',
			mappings = {
				default = {
					after_action = function(selection)
						vim.cmd('Oil ' .. selection.path)
					end
				}
			}
		},
	}
})

pcall(telescope.load_extension, 'fzf') -- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'remote-sshfs') -- Enable telescope remote-sshfs, if installed
pcall(telescope.load_extension, 'ag') -- Enable silver-searcher (ag), if installed
pcall(telescope.load_extension, 'zoxide') -- Enable zoxide, if installed
