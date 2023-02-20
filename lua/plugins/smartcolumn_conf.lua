local status, smartcolumn = pcall(require, 'smartcolumn')
if not status then
	return
end

smartcolumn.setup({
	colorcolumn = 80,
	disabled_filetypes = {
		'help', 'text', 'markdown', 'latex', 'NvimTree', 'TelescopePrompt',
		'startup', 'lazy', 'mason'
	}
})
