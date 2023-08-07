return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
            border_style = "round"
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'     -- optional
    },
}
