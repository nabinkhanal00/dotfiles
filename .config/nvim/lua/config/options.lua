-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.expandtab = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.clipboard = ""
opt.swapfile = false
opt.guifont = "JetBrainsMono Nerd Font:h18"

if vim.g.neovide then
	vim.g.neovide_transparency = 0.8
end
