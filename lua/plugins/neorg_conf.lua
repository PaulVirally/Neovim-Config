-- Neorg config

pcall(function ()
	require('neorg').setup({
		load = {
			['core.defaults'] = {}, -- Load all the default modules
			['core.norg.concealer'] = {}, -- Allows for use of icons
			['core.norg.dirman'] = { -- Manage your directories with Neorg
				config = {
					workspaces = {
						waterloo = '/Users/pvirally/Dropbox/neorg/Waterloo',
						poly = '/Users/pvirally/Dropbox/neorg/Poly',
					},
				},
			},
		},
	})
end)
