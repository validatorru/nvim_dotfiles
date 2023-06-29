return {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    config = function()
        require('telescope').setup({
            extensions = {
                media_files = {
                    -- filetypes whitelist
                    -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                    filetypes = {"png", "webp", "jpg", "jpeg"},
                    -- find command (defaults to `fd`)
                    find_cmd = "rg"
                }
            },
        })
        local builtin = require('telescope.builtin')
        require('telescope').load_extension('media_files')
        require('telescope').load_extension('http')
        require('telescope').load_extension('coc')
        require('telescope').load_extension('tmux')
        require('telescope').load_extension('tele_tabby')
        -- Open find files 
        vim.keymap.set('n', ',ff', builtin.find_files, {})
        -- Open text search
        vim.keymap.set('n', ',fg', builtin.live_grep, {})
        --  Open buffers list
        vim.keymap.set('n', ',fb', builtin.buffers, {})
        -- Open tabs list
        vim.keymap.set('n', ',ft', ':Telescope tele_tabby list <CR>', {})
        -- Open media files
        vim.keymap.set('n', ',fm', ':Telescope media_files <CR>', {})
        -- Open media files
        vim.keymap.set('n', ',fs', ':Telescope tmux sessions <CR>', {})

    end,
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-lua/popup.nvim'},
        {'camgraff/telescope-tmux.nvim'},
        {'TC72/telescope-tele-tabby.nvim'},
        {'fannheyward/telescope-coc.nvim'},
        {'barrett-ruth/telescope-http.nvim'},
        {'nvim-telescope/telescope-media-files.nvim'},
        {"nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        }
    },
}
