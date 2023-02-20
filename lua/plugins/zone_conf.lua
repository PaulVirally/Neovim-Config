require('zone').setup({
	style = 'dvd',
	after = 5*60, -- 5 minutes
	exclude_filetypes = {
		'NvimTree', 'TelescopePrompt', 'startup', 'lazy', 'mason'
	},
	dvd = {
		tick_time = 50
	}
})
