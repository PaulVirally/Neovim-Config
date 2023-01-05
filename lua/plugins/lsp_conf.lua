-- Neovim lua config
require('neodev').setup()

local palette = require('catppuccin.palettes').get_palette('macchiato')
vim.cmd('autocmd! ColorScheme * highlight NormalFloat guibg=' .. palette.base)
vim.cmd('autocmd! ColorScheme * highlight FloatBorder guifg=' .. palette.overlay2 .. 'guibg=' .. palette.base)
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
	['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
		update_in_insert = false,
	}),
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
	rust_analyzer = {}, -- Rust
	tsserver = {}, -- JavaScript, TypeScript, etc.
	ltex = {}, -- LaTeX
	sumneko_lua = { -- Lua
		Lua = {
			workspace = {checkThirdParty = false},
			telemetry = {enable = false},
		},
	},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
