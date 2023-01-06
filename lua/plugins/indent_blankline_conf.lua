-- Indent blank line config

require('indent_blankline').setup({
	buftype_exclude = {'terminal', 'fidget'},
	filetype_exclude = {'help', 'NvimTree', 'TelescopePrompt', 'TelescopeResults', 'lazy', 'fidget'},
	show_trailing_blankline_indent = false,
	show_current_context = true,
})
