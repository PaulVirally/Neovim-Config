-- Neorg config

local status, neorg = pcall(require, 'neorg')
if not status then
	return
end
neorg.setup({
	load = {
		['core.defaults'] = {}, -- Load all the default modules
		['core.norg.concealer'] = {}, -- Allows for use of icons
		['core.norg.dirman'] = { -- Manage your directories with Neorg
			config = {
				workspaces = {
					notes = '/Users/pvirally/Dropbox/neorg/notes',
					waterloo = '/Users/pvirally/Dropbox/neorg/Waterloo',
					poly = '/Users/pvirally/Dropbox/neorg/Poly',
				},
			},
		},
	},
})
