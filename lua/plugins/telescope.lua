return {
    'nvim-telescope/telescope.nvim',

    config = function()
        -- vim.api.nvim_set_hl(0, "TelescopeBorder", {bg="#00ff00"})
        -- vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="#110000"})
        -- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {bg="#ff0000"})

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
                -- This might also help
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
                media_files = {
                    -- filetypes whitelist
                    -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                    filetypes = {"png", "webp", "jpg", "jpeg"},
                    -- find command (defaults to `fd`)
                    find_cmd = "rg",
                    image_stretch = 100
                },
                aerial = {
                    -- Display symbols as <root>.<parent>.<symbol>
                    show_nesting = {
                        ['_'] = false, -- This key will be the default
                        json = true,   -- You can set the option for specific filetypes
                        yaml = true,
                    }
                },
            },
        })
        local builtin = require('telescope.builtin')
        require('telescope').load_extension('media_files')
        require('telescope').load_extension('env')
        require("telescope").load_extension("noice")
        require('telescope').load_extension('git_diffs')

        -- Open find files 
        vim.keymap.set('n', ',ff', builtin.find_files, {})
        vim.keymap.set('n', ',fo', builtin.oldfiles, {})
        -- Open text search
        vim.keymap.set('n', ',fg', builtin.live_grep, {})
        vim.keymap.set('n', ',fG', builtin.grep_string, {})
        --  Open buffers list
        vim.keymap.set('n', ',fb', builtin.buffers, {})
        -- Open tabs list
        vim.keymap.set('n', ',ft', ':Telescope telescope-tabs list_tabs theme=ivy <CR>', {})
        -- Open media files
        vim.keymap.set('n', ',fm', ':Telescope media_files <CR>', {})
        -- Open symbols list
        vim.keymap.set('n', ',fa', ':Telescope aerial theme=ivy <CR>', {})
        -- vim.keymap.set('n', ',fa', ':Telescope aerial <CR>', {})
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
        {'nvim-lua/popup.nvim'},
        {'LinArcX/telescope-env.nvim'},
        {'LukasPietzschmann/telescope-tabs'},
        {'nvim-telescope/telescope-media-files.nvim'},
        {'paopaol/telescope-git-diffs.nvim',
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
            },
        },
        {"nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        }
    },
}
