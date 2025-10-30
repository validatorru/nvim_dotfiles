return {
    'nvim-lualine/lualine.nvim',

    config = function()
        --
        -- A function to check the status and return the corresponding icon
        --
        local function get_status_icon()
            local status = require("ollama").status()

            if status == "IDLE" then
                return "-"
            elseif status == "WORKING" then
                return "🧠"
            end
        end

        require('lualine').setup {
            options = {
                theme = "zenbones",
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
                lualine_a = {
                    {
                        'mode',
                        separator = { left = '' },
                        right_padding = 2
                    }
                },
                lualine_b = {
                    {
                        'filename',
                        path = 1
                    },
                    'branch',
                },
                lualine_c = {
                    '%=', -- empty
                },
                lualine_x = {
                    "aerial",
                    -- '%=', -- empty
                },
                lualine_y = {
                    'location',
                },
                lualine_z = {
                    {
                        'progress',
                        -- '%=', -- empty
                        -- 'filetype',
                        separator = { left = '', right = '' },
                        right_padding = 2
                    }
                },
            },
            inactive_sections = {
                lualine_a = {
                    {
                        'filename',
                        path = 1
                    },
                    'location',
                },
                lualine_b = {
                    '%=', -- empty
                },
                lualine_c = {
                    '%=', -- empty
                },
                lualine_x = {  },
                lualine_y = { 'filetype', 'progress' },
            },
            tabline = {
                lualine_a = {
                    {
                        'tabs',
                        mode = 2,
                        separator = { left = '', right = '' },
                        symbols = {
                            modified = ' ●',      -- Text to show when the buffer is modified
                            alternate_file = '#', -- Text to show to identify the alternate file
                            directory =  '',     -- Text to show when the buffer is a directory
                        },
                        use_mode_colors = true,
                        tabs_color = {
                            -- Same values as the general color option can be used here.
                            active = { fg = '#333333', bg = '#eeeeee', gui = 'bold' },
                            -- inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
                        },
                    }
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    get_status_icon,
                },
                lualine_z = {
                    {
                        'filetype',
                        separator = { left = '', right = '' },
                        right_padding = 2
                    }
                },
            },
            extensions = {},
        }
    end,
    dependencies = { 'nvim-web-devicons' }
}

