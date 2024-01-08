local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if path does not exist - clone repo and install
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
-- "plugins" is lua/plugins.lua file and plugins directory
require("lazy").setup("plugins")
