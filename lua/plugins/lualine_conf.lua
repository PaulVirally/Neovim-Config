-- Lualine config

require('lualine').setup({
	options = {
		theme = 'catppuccin',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename', require('recorder').recordingStatus },
		lualine_x = {require('recorder').displaySlots, 'encoding', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
})
