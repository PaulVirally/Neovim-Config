-- Colorscheme
vim.cmd('colorscheme catppuccin-macchiato')

-- Sync neovim clipboard and system clipboard
vim.opt.clipboard:prepend({'unnamedplus'})

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the line that cursor is on
vim.opt.cursorline = true

-- Open new split windows to the right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tabs >> spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
