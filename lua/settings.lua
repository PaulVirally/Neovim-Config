-- Colorscheme
vim.cmd('colorscheme catppuccin-mocha')

-- Sync neovim clipboard and system clipboard
vim.opt.clipboard:prepend({'unnamedplus'})

-- Line numbers
vim.opt.number = true

-- Highlight the line that cursor is on
vim.opt.cursorline = true

-- Open new split windows to the right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tabs >> spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Enable mouse everywhere
vim.opt.mouse = 'a'

-- Save undo history
vim.opt.undofile = true

-- Have the status line span the entire screen, even when splitting windows
vim.opt.laststatus = 3

-- Smart case searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Better completion window
vim.opt.completeopt = {'menuone', 'noselect'}

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_ca'

-- Stop automatically adding comment lines
local comment_group = vim.api.nvim_create_augroup('NoAutoComment', {clear = true})
vim.api.nvim_create_autocmd('FileType', {
	command = 'set formatoptions-=cro',
	group = comment_group,
})

-- Hide end of buffer characters
vim.wo.fillchars='eob: '

-- Don't wrap lines
vim.opt.wrap = false

-- Set textwidth to 80. This is useful for `gw` to format docstrings or comments
vim.opt.textwidth = 70
