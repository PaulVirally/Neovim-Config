require('luasnip').setup({
	history = true,
})
require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/lua/snippets/'})
