function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    config = function()
        require("toggleterm").setup({
            direction = 'float',
            shade_terminals = true,
            shading_factor = '40',
            hide_numbers = true,
            float_opts = {
                -- border = 'curved',
                border = 'shadow',
                width = 185
            },
        })
        vim.keymap.set(
            'n',
            '<C-t>',
            '<Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>',
            {silent = true}
        )
        vim.keymap.set(
            'n',
            '<S-t>',
            '<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>',
            {silent = true}
        )
    end,
}
