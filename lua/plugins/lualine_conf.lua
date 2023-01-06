-- Lualine config

require('lualine').setup({
	options = {
		theme = 'catppuccin',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
})
