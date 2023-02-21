local status, glance = pcall(require, 'glance')
if not status then
  return
end

glance.setup()

-- Color definitions
local palette = require('catppuccin.palettes').get_palette('macchiato')
vim.api.nvim_set_hl(0, 'GlanceListNormal', {fg = palette.text, bg = palette.mantle})
vim.api.nvim_set_hl(0, 'GlancePreviewEndOfBuffer', {link = 'EndOfBuffer'})
vim.api.nvim_set_hl(0, 'GlancePreviewMatch', {link = 'Search'})
vim.api.nvim_set_hl(0, 'GlancePreviewNormal', {fg = palette.text, bg = palette.mantle})
vim.api.nvim_set_hl(0, 'GlancePreviewSignColumn', {link = 'SignColumn'})
vim.api.nvim_set_hl(0, 'GlanceWinBarFilename', {fg = palette.text, bg = palette.crust})
vim.api.nvim_set_hl(0, 'GlanceWinBarFilepath', {fg = palette.surface2, bg = palette.crust})
vim.api.nvim_set_hl(0, 'GlanceWinBarTitle', {bg = palette.crust})
