local palette = require('catppuccin.palettes').get_palette('mocha')

require('scrollbar').setup({
	handle = {
		-- color = palette.mantle,
		color = palette.overlay0,
	},
	marks = {
		GitAdd = { text = '┃'},
		GitChange = { text = '┃'},
	},
	excluded_filetypes = { 'startup', 'NvimTree' },
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true,
		handle = true,
	},
})
