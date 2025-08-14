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
--      {'╭', 'FloatBorder'},
--      {'─', 'FloatBorder'},
--      {'╮', 'FloatBorder'},
--      {'│', 'FloatBorder'},
--      {'╯', 'FloatBorder'},
--      {'─', 'FloatBorder'},
--      {'╰', 'FloatBorder'},
--      {'│', 'FloatBorder'},
-- }
-- local handlers = {
--      ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
--              border = border,
--      }),
--      ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--              border = border,
--      }),
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
require('mason').setup({
        ui = {
                border = 'rounded',
        },
})

local mason_lsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason_lsp.setup({
        ensure_installed = {
                'bashls',
                'pyright',
                'tsserver',
                'julials',
                'lua_ls',
        },
})

mason_lsp.setup_handlers({
        function(server_name)
                lspconfig[server_name].setup({
                        capabilities = capabilities,
                })
        end,
        ['julials'] = function()
                local util = require('lspconfig.util')
                lspconfig.julials.setup({
                        capabilities = capabilities,
                        on_new_config = function(new_config, _)
                                local julia = vim.fn.expand('~/.julia/environments/nvim-lspconfig/bin/julia')
                                if util.path.exists(julia) then
                                        new_config.cmd[1] = julia
                                end
                        end,
                        cmd = {
                                'julia',
                                '--startup-file=no',
                                '--history-file=no',
                                '-e', [[
                                        using LanguageServer; using Pkg; using SymbolServer;
                                        env_path = dirname(Pkg.Types.Context().env.project_file);
                                        server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
                                        server.runlinter = true;
                                        run(server);
                                ]],
                        },
                })
        end,
        ['lua_ls'] = function()
                lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                                Lua = {
                                        workspace = { checkThirdParty = false },
                                        telemetry = { enable = false },
                                },
                        },
                })
        end,
})

-- LSP status info
require('fidget').setup({})

-- Folding
require('ufo').setup()
