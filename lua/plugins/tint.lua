return {
    'levouh/tint.nvim',
    config = function()
        require('tint').setup({
            tint = -5,  -- Darken colors, use a positive value to brighten
            saturation = 0.7,  -- Saturation to preserve
            tint_background_colors = true,  -- Tint background portions of highlight groups
        })
    end,
}
