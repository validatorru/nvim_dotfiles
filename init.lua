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
vim.opt.mouse = 'nicr'
vim.opt.mousescroll = 'ver:5,hor:2'
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
vim.opt.foldcolumn = '1'
vim.opt.colorcolumn = '79'
vim.api.nvim_set_option_value("termguicolors", true, {
  scope = "local",
})
vim.api.nvim_set_option_value("colorcolumn", "79", {
  scope = "local",
})
vim.opt.cursorline = false
vim.o.signcolumn = "number"
-- vim.opt.signcolumn = "number"


vim.api.nvim_create_user_command('Q', 'q', {})
-- Enter normal mode when certain rarely used keys are triggered
vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kk', '<esc>')

-- Remove search highlights
vim.keymap.set('n', ',<space>', ':nohlsearch<CR>')

-- Cycle buffers by space + arrow
vim.keymap.set('n', '<Space><Up>', ':bp<CR>')
vim.keymap.set('n', '<Space><Down>', ':bn<CR>')
vim.keymap.set('n', '<Space><Right>', ':tabn<CR>')
vim.keymap.set('n', '<Space><Left>', ':tabp<CR>')

-- Cycle buffers by space + nav keys
vim.keymap.set('n', '<space>j', ':bp<CR>')
vim.keymap.set('n', '<space>k', ':bn<CR>')
vim.keymap.set('n', '<space>h', ':tabn<CR>')
vim.keymap.set('n', '<space>l', ':tabp<CR>')

vim.keymap.set('n', ',c', ':set cc=<CR>')
vim.keymap.set('n', ',C', ':set cc=79<CR>')

-- VueJS file settings
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.vue"},
--   command = "setlocal filetype=vue",
-- })
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.vue"},
--   command = "setlocal expandtab", })
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.vue"},
--   command = "setlocal tabstop=2",
-- })
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.vue"},
--   command = "setlocal softtabstop=2",
-- })
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.vue"},
--   command = "setlocal shiftwidth=2",
-- })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter", "BufWinEnter", }, {
  pattern = {"*.blade.php"},
  command = "set filetype=blade",
})

-- augroup BladeFiltypeRelated
--   au BufNewFile,BufRead *.blade.php set ft=blade
-- augroup END


vim.g.mapleader = "<Space>"
vim.g.maplocalleader = "<Space>"

-- Start lazy nvim 
require("lazy").setup("plugins")


-- we can use 'ca' to expand an abbr in command mode
-- or we could use 'ia' to expand an abbr in insert mode
vim.keymap.set('ia', 'clls', "console.log('')<ESC>F';a")
vim.keymap.set('ia', 'lgi', "logging.info(f'')<ESC>F';a")
vim.keymap.set('ia', 'hml', "hm_log(f'')<ESC>F';a")
vim.keymap.set('ia', 'importhm', "from helpers.logging_helper import hm_log<ESC>")


-- blade files treesitter

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "blade"
}
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd

-- autocmd('BufRead',  {
--   pattern='*.blade.php',
--   command='set ft=blade'
-- })
-- autocmd('BufNewFile,BufRead',  {
--   pattern='*.blade.php',
--   command='set ft=blade'
-- })

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
})
-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd[[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  augroup END
]]
-- Enable twilight by default
vim.cmd("TwilightEnable")

vim.opt.virtualedit = "block"
