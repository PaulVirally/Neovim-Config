-- Disable netrw so that nvim-tree works correctly
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Close the file explorer before closing neovim
local exit_group = vim.api.nvim_create_augroup('ExitGroup', {clear = true})
vim.api.nvim_create_autocmd('VimLeavePre', {
	command = 'NvimTreeClose',
	group = exit_group
})

-- This is to appease noice.nvim on startup. Colours from catppuccin mocha: fg = text, bg = base
vim.api.nvim_set_hl(0, 'NotifyBackground', {fg = '#cdd6f4', bg = '#1e1e2e'})
