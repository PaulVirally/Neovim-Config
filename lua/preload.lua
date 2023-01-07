-- Disable netrw so that nvim-tree works correctly
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Close the file explorer before closing neovim
local exit_group = vim.api.nvim_create_augroup('ExitGroup', {clear = true})
vim.api.nvim_create_autocmd('VimLeavePre', {
	command = 'NvimTreeClose',
	group = exit_group
})
