-- Catppuccin config

require('catppuccin').setup({
	flavour = 'mocha',
	integrations = {
		fidget = true,
		gitsigns = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		mason = true,
		-- noice = true,
		cmp = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = {'italic'},
				hints = {'italic'},
				warnings = {'italic'},
				information = {'italic'},
			},
			underlines = {
				errors = {'underline'},
				hints = {'underline'},
				warnings = {'underline'},
				information = {'underline'},
			},
		},
		treesitter = true,
		telescope = true,
		lsp_trouble = true,
		which_key = true,
	}
})
