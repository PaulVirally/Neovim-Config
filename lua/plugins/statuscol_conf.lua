vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = '',
		}
	}
})

local builtin = require("statuscol.builtin")
require("statuscol").setup({
	ft_ignore = { 'startup', 'NvimTree' },
	segments = {
		{ -- Git
			sign = { namespace = { "gitsign" }, maxwidth = 1, auto = true },
			click = "v:lua.ScSa"
		},
		{ -- Folds
			text = { builtin.foldfunc, " " },
			condition = { true, builtin.not_empty },
			click = "v:lua.ScFa"
		},
		{ -- Diagnostic symbols (not showing up)
			sign = { namespace = { "diagnostic" }, maxwidth = 1, auto = true },
			click = "v:lua.ScSa"
		},
		{ -- Line numbers
			text = { builtin.lnumfunc, " " },
			condition = { true, builtin.not_empty },
			click = "v:lua.ScLa",
		},
		{ -- Everything else
			sign = { name = { ".*" }, maxwidth = 4, colwidth = 1, auto = true },
			click = "v:lua.ScSa"
		},
	},
})
