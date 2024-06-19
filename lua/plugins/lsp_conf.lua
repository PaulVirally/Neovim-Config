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
local border = {
	{'╭', 'FloatBorder'},
	{'─', 'FloatBorder'},
	{'╮', 'FloatBorder'},
	{'│', 'FloatBorder'},
	{'╯', 'FloatBorder'},
	{'─', 'FloatBorder'},
	{'╰', 'FloatBorder'},
	{'│', 'FloatBorder'},
}
local handlers = {
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = border,
	}),
	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = border,
	}),
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end
		vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
	end

	-- TODO: Move all of these to caskey_conf.lua
	nmap('<Leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<Leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<Leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<Leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<Leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {desc = 'Format current buffer with LSP'})
end

local servers = {
	clangd = {}, -- C, C++, etc.
	pyright = {}, -- Python
	ruff_lsp = {}, -- Python
	rust_analyzer = {}, -- Rust
	julials = {}, -- Julia
	tsserver = {}, -- JavaScript, TypeScript, etc.
	quick_lint_js = {}, -- JavaScript linter
	ltex = {}, -- Spelling and grammar in LaTeX
	texlab = {}, -- LaTeX
	lua_ls = { -- Lua
		Lua = {
			workspace = {checkThirdParty = false},
			telemetry = {enable = false},
		},
	},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			handlers = handlers,
		}
	end,
})

-- LSP status info
require('fidget').setup()

-- Folding
require('ufo').setup()
