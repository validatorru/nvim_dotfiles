return {
    'sunjon/shade.nvim',
    config = function()
        require('shade').setup({
            overlay_opacity = 40,
        })
    end,
}
