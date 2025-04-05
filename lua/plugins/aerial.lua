return {
    'stevearc/aerial.nvim',
    config = function()
        require('aerial').setup({
            layout = {
                max_width = { 40, 0.5 },
                default_direction = "prefer_right",
                resize_to_content = true,
            }
        })
        -- Set a keymap to toggle aerial
        vim.keymap.set('n', ',aa', '<cmd>AerialToggle<CR>')
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
}
