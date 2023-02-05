require('session_manager').setup({
	autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Don't autoload a session when opening neovim with no args
	autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
	autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
		'gitcommit',
		'NvimTree',
	},
	autosave_ignore_buftypes = {}, -- All buffers of these buffer types will be closed before the session is saved.
	max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})
