-- Enable lazy nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

-- Custom nvim settings
vim.opt.number = true
vim.opt.rnu = true
vim.opt.mouse = 'a'
vim.opt.encoding = 'utf-8'
vim.opt.swapfile = false
vim.opt.scrolloff = 1
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = unix
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldcolumn = '3'
vim.opt.colorcolumn = '79'
vim.opt.cursorline = true
vim.opt.foldcolumn = '4'


-- Enter normal mode when certain rarely used keys are triggered
vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kk', '<esc>')

-- Remove search highlights
vim.keymap.set('n', ',<space>', ':nohlsearch<CR>')

-- Cicle buffers by space + arrow
vim.keymap.set('n', '<Space><Up>', ':bp<CR>')
vim.keymap.set('n', '<Space><Down>', ':bn<CR>')
vim.keymap.set('n', '<Space><Right>', ':tabn<CR>')
vim.keymap.set('n', '<Space><Left>', ':tabp<CR>')

-- Cicle buffers by space + nav keys
vim.keymap.set('n', '<Space>k', ':bp<CR>')
vim.keymap.set('n', '<Space>j', ':bn<CR>')
vim.keymap.set('n', '<Space>l', ':tabn<CR>')
vim.keymap.set('n', '<Space>h', ':tabp<CR>')

-- VueJS file settings
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.vue"},
  command = "setlocal filetype=vue",
})
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.vue"},
  command = "setlocal expandtab",
})
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.vue"},
  command = "setlocal tabstop=2",
})
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.vue"},
  command = "setlocal softtabstop=2",
})
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.vue"},
  command = "setlocal shiftwidth=2",
})


-- Start lazy nvim 
require("lazy").setup("plugins")
