-- Set leader keys at the VERY TOP - before any other config
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable lazy nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

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
vim.o.fileformat = 'unix'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldcolumn = '1'
vim.o.colorcolumn = '79'
vim.o.cursorline = true
vim.o.cursorlineopt ='both'
vim.o.signcolumn = 'yes'

vim.g.virtcolumn_char = '𐩑'
vim.g.virtcolumn_priority = 10 

vim.api.nvim_set_option_value("termguicolors", true, {
    scope = "local",
})

vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#3c3836' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000' })
vim.api.nvim_set_hl(0, 'PmenuSel', { fg = '#000000' })

vim.api.nvim_create_user_command('Q', 'q', {})

vim.api.nvim_create_autocmd(
    {"BufNewFile", "BufRead", "BufEnter", "BufWinEnter", },
    {
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

-- Start lazy nvim 
require("lazy").setup("plugins")

-- we can use 'ca' to expand an abbr in command mode
-- or we could use 'ia' to expand an abbr in insert mode
vim.keymap.set('ia', 'clls', "console.log('')<ESC>F';a")
vim.keymap.set('ia', 'lgi', "logging.info(f'')<ESC>F';a")

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
        au TextYankPost * silent! lua vim.highlight.on_yank({ higroup="Visual", timeout=200 })
        augroup END
]]
 
-- vim.opt.virtualedit = "all"

vim.diagnostic.config({
    virtual_lines = true
})


vim.g.loaded_ruby_provider = 0

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.timeoutlen = 2000
vim.g.loaded_perl_provider = 0
require('render-markdown').setup({ latex = { enabled = false } })

vim.api.nvim_set_hl(0, 'ColorColumn', { bg = 'none', fg = '#612f33' })  -- Fixed: 'none' should be string

vim.api.nvim_set_hl(0, "FloatBorder", {bg="#1e222a", fg="#999999"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg="#1a1a1a", fg="#999999"})


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
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#010101' })
end, 100)

-- HTML tag stripping function - ADVANCED NEWLINE PRESERVATION
vim.keymap.set('v', ' s', function()
    local start_pos = vim.api.nvim_buf_get_mark(0, '<')
    local end_pos = vim.api.nvim_buf_get_mark(0, '>')
    
    -- Get the selected text
    local lines = vim.api.nvim_buf_get_text(0, 
        start_pos[1]-1, start_pos[2], end_pos[1]-1, end_pos[2], {})
    
    local selected_text = table.concat(lines, '\n')
    if selected_text == '' then return end
    
    -- Process each line individually to preserve newlines
    local result_lines = {}
    for _, line in ipairs(lines) do
        -- Strip HTML tags from this line
        local cleaned_line = line:gsub('<[^>]+>', '')
        -- Clean up whitespace within the line (but preserve the line itself)
        cleaned_line = cleaned_line:gsub('[%s\t]+', ' ')
        cleaned_line = cleaned_line:gsub('^%s*(.-)%s*$', '%1')
        table.insert(result_lines, cleaned_line)
    end
    
    -- Remove empty lines at the beginning and end if desired
    while #result_lines > 0 and result_lines[1] == '' do
        table.remove(result_lines, 1)
    end
    while #result_lines > 0 and result_lines[#result_lines] == '' do
        table.remove(result_lines, #result_lines)
    end
    
    -- Replace the selected text
    vim.api.nvim_buf_set_text(0, 
        start_pos[1]-1, start_pos[2], end_pos[1]-1, end_pos[2], 
        result_lines)
end, { noremap = true, silent = true, desc = "Strip HTML tags (keep newlines)" })






local scooter_term = nil

-- Called by scooter to open the selected file at the correct line from the scooter search list
_G.EditLineFromScooter = function(file_path, line)
    if scooter_term and scooter_term:buf_valid() then
        scooter_term:hide()
    end

    local current_path = vim.fn.expand("%:p")
    local target_path = vim.fn.fnamemodify(file_path, ":p")

    if current_path ~= target_path then
        vim.cmd.edit(vim.fn.fnameescape(file_path))
    end

    vim.api.nvim_win_set_cursor(0, { line, 0 })
end

local function is_terminal_running(term)
    if not term or not term:buf_valid() then
        return false
    end
    local channel = vim.fn.getbufvar(term.buf, 'terminal_job_id')
    return channel and vim.fn.jobwait({channel}, 0)[1] == -1
end

local function open_scooter()
    if is_terminal_running(scooter_term) then
        scooter_term:toggle()
    else
        scooter_term = require("snacks").terminal.open("scooter", {
            win = { position = "float" },
        })
    end
end

local function open_scooter_with_text(search_text)
    if scooter_term and scooter_term:buf_valid() then
        scooter_term:close()
    end

    local escaped_text = vim.fn.shellescape(search_text:gsub("\r?\n", " "))
    scooter_term = require("snacks").terminal.open("scooter --fixed-strings --search-text " .. escaped_text, {
        win = { position = "float" },
    })
end

vim.keymap.set('n', '<leader>S', open_scooter, { desc = 'Open scooter' })
vim.keymap.set('v', '<leader>r',
    function()
        local selection = vim.fn.getreg('"')
        vim.cmd('normal! "ay')
        open_scooter_with_text(vim.fn.getreg('a'))
        vim.fn.setreg('"', selection)
    end,
    { desc = 'Search selected text in scooter' })




-- performance
vim.o.lazyredraw = true
vim.cmd.syntax("manual")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitsendemail", "conf", "editorconfig", "qf", "checkhealth", "less" },
  callback = function(event)
    vim.bo[event.buf].syntax = vim.bo[event.buf].filetype
  end,
})

vim.opt.synmaxcol = 500

vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#ff0000", bg = "#000000" })
