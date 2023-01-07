-- Startup config

require('startup').setup({
	title_section = {
		type = 'text',
		align = 'center',
		fold_section = false,
		title = 'Header',
		margin = 5,
		content = {
			[[ _   _                 _     _      ]],
			[[| \ | | ___  _____   _(_) __| | ___ ]],
			[[|  \| |/ _ \/ _ \ \ / / |/ _` |/ _ \]],
			[[| |\  |  __/ (_) \ V /| | (_| |  __/]],
			[[|_| \_|\___|\___/ \_/ |_|\__,_|\___|]],
		},
		highlight = 'Statement',
		default_color = '',
		oldfiles_amount = 0,
	},
	mappings_section = {
		type = 'mapping',
		align = 'center',
		fold_section = false,
		title = 'Mappings',
		margin = 5,
		content = {
			{' Load Last Session', 'lua require("persistence").load({last=true})', '<leader>ql'},
			{' Find File', 'lua require("telescope").extensions.frecency.frecency()', '<leader>sf'},
			{' File Browser', 'NvimTreeToggle', '<leader>t'},
			{' New File', 'lua require("startup").new_file()', '<leader>nf'},
		},
		highlight = 'String',
		default_color = '',
		oldfiles_amount = 0,
	},
	oldfiles_section = {
		type = 'oldfiles',
		oldfiles_directory = false,
		align = 'center',
		fold_section = false,
		title = 'Old files',
		margin = 5,
		content = {},
		highlight = 'String',
		oldfiles_amount = 10,
	},
	options = {
	},
	mappings = {
	},
	parts = {
		'title_section',
		'mappings_section',
		'oldfiles_section',
	},
})
