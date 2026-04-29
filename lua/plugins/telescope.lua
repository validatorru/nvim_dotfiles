return {
    'nvim-telescope/telescope.nvim',

    config = function()
        vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="#000000"})
        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", {bg="#1a1a1a"})
        vim.api.nvim_set_hl(0, "TelescopePrompt", {bg="#000000"})
        vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {bg="#ff0000"})
        
        local actions = require('telescope.actions')

        require('telescope').setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules", "public", "vendor", "*.min.*"
                },
                -- border = true,
                -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
                border = false,
                borderchars = false,
                layout_config = {
                    horizontal = {
                        preview_width = 0.6,
                        -- prompt_position = "bottom",
                        -- Remove any border-related settings
                    },
                    vertical = {
                        -- width = 0.9,
                        preview_width = 0.6,
                    },
                },
                winblend = 0,
                mappings = {
                    i = {
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["<C-l>"] = false,
                    },
                    n = {
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["<C-l>"] = false,
                    }
                },
            },
            pickers = {
                find_files = {
                    theme = "ivy",
                    border = false
                },
                live_grep = {
                    theme = "ivy",
                    border = false

                },
                grep_string  = {
                    theme = "ivy",
                    border = false
                },
                oldfiles  = {
                    theme = "ivy",
                    border = false
                },
                buffers = {
                    theme = "ivy",
                    sort_lastused = true,
                    border = false,
                    mappings = {
                        n = {
                            ["<c-x>"] = actions.delete_buffer,
                        },
                        i = {
                            ["<c-x>"] = actions.delete_buffer,
                        }
                    }
                },
            },
            extensions = {
            },
        })
        local builtin = require('telescope.builtin')
        require('telescope').load_extension('env')
        require("telescope").load_extension("noice")

        -- Open find files 
        vim.keymap.set('n', ',ff', builtin.find_files, {})
        vim.keymap.set('n', ',fo', builtin.oldfiles, {})
        -- Open text search
        vim.keymap.set('n', ',fg', builtin.live_grep, {})
        vim.keymap.set('n', ',fG', builtin.grep_string, {})
        --  Open buffers list
        vim.keymap.set('n', ',fb', builtin.buffers, {})
        -- Open tabs list
        vim.keymap.set('n', ',fm', builtin.marks, {})

        -- - Enable mouse in Telescope (add this after setup)
        vim.cmd([[
            augroup TelescopeMouse
                autocmd!
                autocmd FileType TelescopePreview setlocal mouse=a
            augroup END
        ]])

    end,
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {'LinArcX/telescope-env.nvim'},
        {"nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        }
    },
}
