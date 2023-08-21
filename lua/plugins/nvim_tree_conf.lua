local function custom_on_attach(bufnr)
	local api = require('nvim-tree.api')
	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr) -- Default mappings

	-- Custom mappings
	vim.keymap.set('n', 'X', api.tree.toggle_git_clean_filter, opts('Toggle Filter: Git Clean'))
	vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
end

require('nvim-tree').setup({
	on_attach = custom_on_attach,
	view = {
		adaptive_size = true,
		side = 'right',
	},
	actions = {
		change_dir = {
			global = false -- Set to true to use :cd instead of :lcd
		}
	},
	update_focused_file = {
		enable = true,
		-- update_cwd = true,
	},
	modified = {
		enable = true,
	},
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = '',
				},
			},
		},
	},
})

-- Changes vim's working directory to the current file's directory
local cwd_group = vim.api.nvim_create_augroup('CWDOnBufEnter', {clear = true})
vim.api.nvim_create_autocmd('BufEnter', {
	  command = 'silent! lcd %:p:h',
	  group = cwd_group
})
