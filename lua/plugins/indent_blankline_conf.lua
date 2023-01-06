-- Indent blank line config

require('indent_blankline').setup({
	buftype_exclude = {'terminal'},
	filetype_exclude = {'help', 'NvimTree', 'TelescopePrompt', 'TelescopeResults'},
	show_trailing_blankline_indent = false,
	show_current_context = true,
})
