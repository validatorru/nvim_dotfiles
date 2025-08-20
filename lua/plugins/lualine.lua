return {
    'nvim-lualine/lualine.nvim',
    config = function()
        -- Bubbles config for lualine
        -- Author: lokesh-krishna
        -- MIT license, see LICENSE for more details.

        -- stylua: ignore
        -- get colors from
        -- https://github.com/nshern/neovim-default-colorscheme-extras?tab=readme-ov-file
        local colors = {
            -- blue   = '#80a0ff',
            -- cyan   = '#79dac8',
            black  = '#080808',
            white  = '#c6c6c6',
            NvimLightGreen = '#b4f6c0',
            NvimDarkGreen = '#005523',
            NvimDarkGrey1 = '#07080D',
            -- red    = '#ff5189',
            -- violet = '#d183e8',
            grey   = '#303030',
        }

        local bubbles_theme = {
            normal = {
                a = { fg = colors.black, bg = colors.NvimLightGreen },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.white },
            },
            --
            -- insert = { a = { fg = colors.black, bg = colors.blue } },
            -- visual = { a = { fg = colors.black, bg = colors.cyan } },
            -- replace = { a = { fg = colors.black, bg = colors.red } },
            --
            inactive = {
                a = { fg = colors.NvimLightGreen, bg = colors.black },
                b = { fg = colors.NvimLightGreen, bg = colors.black },
                c = { fg = colors.NvimLightGreen },
            },
        }

        require('lualine').setup {
            -- options = { theme = "zenbones" },
            options = {
                -- theme = bubbles_theme,
                theme = "zenbones",
                -- theme = "neobones",
                -- theme = "zenwritten",
                component_separators = '',
                section_separators = { left = '', right = '' },
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { { 'filename', path = 1 }, 'branch', 'location' },
                lualine_c = {
                    '%=', -- empty
                },
                lualine_x = {
                    "aerial"
                },
                lualine_y = { 'filetype', 'progress' },
            },
            inactive_sections = {
                lualine_a = {
                    { 'filename', path = 1 },
                    'location',
                },
                lualine_b = { 
                    '%=', -- empty
                },
                lualine_c = {
                    '%=', -- empty
                },
                lualine_x = {
                },
                lualine_y = { 'filetype', 'progress' },
            },
            tabline = {
                lualine_a = {
                    {
                        'tabs',
                        mode = 2,
                    }
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = {},
        }
        -- require('transparent').clear_prefix('lualine')
    end,
    dependencies = { 'nvim-web-devicons' }
}

