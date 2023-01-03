-- Bootstrap lazy.vnim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({"git", "clone", "--filter=blob:none", "--single-branch", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.runtimepath:prepend(lazypath)

-- TODO: vim.g.mapleader = " " -- set mapleader before lazy so the mappings are correct apparently?

require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin"
	}
})
