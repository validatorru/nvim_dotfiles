return {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    config = function()
        require('telescope').setup({})
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', ',ff', builtin.find_files, {})
        vim.keymap.set('n', ',fg', builtin.live_grep, {})
        vim.keymap.set('n', ',fb', builtin.buffers, {})

        local config = require("monokai-pro.config").options
        local colors = require("monokai-pro.colorscheme").setup(config.filter)
        local TelescopeColor = {
            TelescopePromptNormal = { bg = colors.base.dark },
            TelescopeResultsNormal = { bg = colors.base.dark },
            TelescopePreviewNormal = { bg = colors.base.dark },
            TelescopePromptBorder = { bg = colors.base.dark, fg = colors.base.dark },
            TelescopeResultsBorder = { bg = colors.base.dark, fg = colors.base.dark },
            TelescopePreviewBorder = { bg = colors.base.dark, fg = colors.base.dark },
            TelescopePromptTitle = { bg = colors.base.dark, fg = colors.base.white },
        }

        for hl, col in pairs(TelescopeColor) do
            vim.api.nvim_set_hl(0, hl, col)
        end

    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
}
