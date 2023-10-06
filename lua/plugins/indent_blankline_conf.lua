-- Indent blank line config

require('ibl').setup({
	exclude = {
		buftypes = {'terminal', 'widget'},
		filetypes = {'help', 'NvimTree', 'TelescopePrompt', 'TelescopeResults', 'lazy', 'fidget', 'startup', 'mason'},
	},
	whitespace = {
		remove_blankline_trail = false
	}
})
