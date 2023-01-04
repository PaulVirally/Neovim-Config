-- Colorscheme
vim.cmd('colorscheme catppuccin-macchiato')

-- Sync neovim clipboard and system clipboard
vim.opt.clipboard:prepend({'unnamedplus'})

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the line that cursor is on
vim.opt.cursorline = true
