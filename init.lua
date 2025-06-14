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


-- vim.opt.termguicolors
-- vim.opt.background=dark


-- vim.colorscheme zenbones

-- vim.cmd 'colorscheme zenbones'
-- local colorscheme = "zenbones"
local colorscheme = "kanagawabones"
-- local colorscheme = "zenwritten"
-- local colorscheme = "zenwritten"
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
vim.o.background = "dark" -- or "light" for light mode

-- Custom nvim settings
vim.opt.number = true
vim.opt.rnu = true
-- vim.o.statuscolumn = "%v:num %v:relnum %s %C "
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
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#3c3836' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000' })
vim.o.cursorlineopt ='both'
vim.api.nvim_set_option_value("termguicolors", true, {
    scope = "local",
})

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
vim.keymap.set('ia', 'bdr', "border: 1px solid red;<ESC>")


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

vim.opt.virtualedit = "block"

vim.diagnostic.config({
    virtual_lines = true
})


vim.g.loaded_ruby_provider = 0

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.timeoutlen = 2000
vim.g.loaded_perl_provider = 0
require('render-markdown').setup({ latex = { enabled = false } })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = none, fg = '#612f33' })
