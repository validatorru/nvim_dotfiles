return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true
        local bufferline = require('bufferline')
        bufferline.setup{
            options = {
                -- style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
                mode = "tabs", -- set to "tabs" to only show tabpages instead
                separator_style = 'slant',
                themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
            },
        }
        -- vim.cmd("highlight Normal guibg=#000000 guifg=#000000")
    end,
}
