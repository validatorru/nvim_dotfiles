return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup({
            -- options = {
            --     -- theme = 'monokai-pro'
            -- }
        })
    end,
    dependencies = { 'nvim-web-devicons' }
}

