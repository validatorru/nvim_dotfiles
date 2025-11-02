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


-- local colorscheme = "kanagawabones"
-- local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.o.background = "light" -- for light mode

-- Custom nvim settings
vim.o.number = true
vim.o.rnu = true
vim.o.mouse = 'nicr'
vim.o.mousescroll = 'ver:5,hor:2'
vim.o.encoding = 'utf-8'
vim.o.swapfile = false
vim.o.scrolloff = 1
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.fileformat = unix
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldcolumn = '1'
vim.o.colorcolumn = '79'
vim.o.cursorline = true
vim.o.cursorlineopt ='both'
vim.o.signcolumn = 'yes'


-- vim.g.virtcolumn_char = '∙' -- char to display the line
vim.g.virtcolumn_char = '𐩑' -- char to display the line
vim.g.virtcolumn_priority = 10 -- priority of extmark

vim.api.nvim_set_option_value("termguicolors", true, {
    scope = "local",
})

vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#3c3836' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000' })
vim.api.nvim_set_hl(0, 'PmenuSel', { fg = '#000000' })

vim.api.nvim_create_user_command('Q', 'q', {})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter", "BufWinEnter", }, {
    pattern = {"*.blade.php"},
    command = "set filetype=blade",
})

-- Enter normal mode when certain rarely used keys are triggered
vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kk', '<esc>')

-- Remove search highlights
vim.keymap.set('n', ',<space>', ':nohlsearch<CR>')

-- Cycle buffers by space + nav keys
vim.keymap.set('n', '<space>j', ':bp<CR>')
vim.keymap.set('n', '<space>k', ':bn<CR>')
vim.keymap.set('n', '<space>h', ':tabn<CR>')
vim.keymap.set('n', '<space>l', ':tabp<CR>')

vim.keymap.set('n', ',c', ':set cc=<CR>')
vim.keymap.set('n', ',C', ':set cc=79<CR>')


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

vim.opt.virtualedit = "all"

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

-- vim.api.nvim_set_hl(0, "FloatBorder", {bg="#3B4252", fg="#5E81AC"})
vim.api.nvim_set_hl(0, "FloatBorder", {bg="#000000", fg="#999999"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg="#111111"})
vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="#111111"})
vim.api.nvim_set_hl(0, "TelescopeBorder", {bg="#111111"})

-- Define highlight groups for active and inactive buffers
vim.api.nvim_set_hl(0, 'ActiveLineNr', { fg = '#777777', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'InactiveLineNr', { fg = '#2a2a2a', bg = 'NONE' })

-- Function to update line number colors
local function update_line_number_colors()
    local current_win = vim.api.nvim_get_current_win()
    local all_windows = vim.api.nvim_list_wins()
    
    for _, win in ipairs(all_windows) do
        local buf = vim.api.nvim_win_get_buf(win)
        local is_current_win = (win == current_win)
        
        if is_current_win then
            -- Active window
            vim.api.nvim_win_set_option(win, 'winhighlight', 'LineNr:ActiveLineNr')
        else
            -- Inactive window
            vim.api.nvim_win_set_option(win, 'winhighlight', 'LineNr:InactiveLineNr')
        end
    end
end

-- Set up autocommands
local group = vim.api.nvim_create_augroup('BufferLineNumbers', { clear = true })

vim.api.nvim_create_autocmd({'WinEnter', 'BufEnter', 'FocusGained'}, {
    group = group,
    callback = update_line_number_colors
})

vim.api.nvim_create_autocmd({'WinLeave', 'BufLeave', 'FocusLost'}, {
    group = group,
    callback = update_line_number_colors
})

-- Initialize on startup
vim.defer_fn(function()
    update_line_number_colors()
end, 100)

-- this cleans html tags
-- awk 'BEGIN {RS="<[^>]+>"} {gsub(/[\t\n ]+/, " "); print}'
-- vim.api.nvim_set_keymap('v', '<leader>s', '"<ESC>:luarequire("strip_html_tags").run()"<CR>', { noremap = true })
--

