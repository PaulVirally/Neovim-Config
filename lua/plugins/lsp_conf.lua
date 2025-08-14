-- Neovim lua config
require('neodev').setup()

local palette = require('catppuccin.palettes').get_palette('mocha')
local border_group = vim.api.nvim_create_augroup('LspBorder', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
	command = 'highlight NormalFloat guifg=' .. palette.text .. ' guibg=' .. palette.base,
	group = border_group
})
vim.api.nvim_create_autocmd('ColorScheme', {
	command = 'highlight FloatBorder guifg=' .. palette.text .. ' guibg=' .. palette.base,
	group = border_group
})
-- local border = {
-- 	{'╭', 'FloatBorder'},
-- 	{'─', 'FloatBorder'},
-- 	{'╮', 'FloatBorder'},
-- 	{'│', 'FloatBorder'},
-- 	{'╯', 'FloatBorder'},
-- 	{'─', 'FloatBorder'},
-- 	{'╰', 'FloatBorder'},
-- 	{'│', 'FloatBorder'},
-- }
-- local handlers = {
-- 	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 		border = border,
-- 	}),
-- 	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
-- 		border = border,
-- 	}),
-- }
-- vim.lsp.handlers['textDocument/hover'] = handlers['textDocument/hover']
-- vim.lsp.handlers['textDocument/signatureHelp'] = handlers['textDocument/signatureHelp']
-- vim.lsp.util.open_floating_preview = vim.lsp.with(vim.lsp.util.open_floating_preview, {
--     border = border,
-- })

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- Setup mason so it can manage external tooling
require('mason').setup()

-- LSP status info
require('fidget').setup({})

-- Folding
require('ufo').setup()
