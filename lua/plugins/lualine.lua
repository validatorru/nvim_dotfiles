return {
    'nvim-lualine/lualine.nvim',
    config = function()
        -- require('lualine').setup({
        -- options = {
        --     theme = 'gruvbox'
        -- },
        -- sections = {
        --     lualine_x = { "aerial" },
        --
        --     -- Or you can customize it
        --     lualine_y = {{ "aerial",
        --         -- The separator to be used to separate symbols in status line.
        --         sep = ' ) ',
        --
        --         -- The number of symbols to render top-down. In order to render only 'N' last
        --         -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
        --         -- be used in order to render only current symbol.
        --         depth = nil,
        --
        --         -- When 'dense' mode is on, icons are not rendered near their symbols. Only
        --         -- a single icon that represents the kind of current symbol is rendered at
        --         -- the beginning of status line.
        --         dense = false,
        --
        --         -- The separator to be used to separate symbols in dense mode.
        --         dense_sep = '.',
        --
        --         -- Color the symbol icons.
        --         colored = true,
        --     }},
        -- },
    -- })
    -- end,
        -- Bubbles config for lualine
        -- Author: lokesh-krishna
        -- MIT license, see LICENSE for more details.

        -- stylua: ignore
        local colors = {
            blue   = '#80a0ff',
            cyan   = '#79dac8',
            black  = '#080808',
            white  = '#c6c6c6',
            red    = '#ff5189',
            violet = '#d183e8',
            grey   = '#303030',
        }

        local bubbles_theme = {
            normal = {
                a = { fg = colors.black, bg = colors.violet },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.white },
            },

            insert = { a = { fg = colors.black, bg = colors.blue } },
            visual = { a = { fg = colors.black, bg = colors.cyan } },
            replace = { a = { fg = colors.black, bg = colors.red } },

            inactive = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.black },
                c = { fg = colors.white },
            },
        }

        require('lualine').setup {
            options = {
                theme = bubbles_theme,
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { 'filename', 'branch' },
                lualine_c = {
                    '%=', --[[ add your center compoentnts here in place of this comment ]]
                },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
            },
            tabline = {},
            extensions = {},
        }
    end,
    dependencies = { 'nvim-web-devicons' }
}

