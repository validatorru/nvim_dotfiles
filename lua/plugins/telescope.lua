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
        vim.keymap.set('n', ',ff', builtin.find_files, {})
        vim.keymap.set('n', ',fg', builtin.live_grep, {})
        vim.keymap.set('n', ',fb', builtin.buffers, {})

    end,
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-lua/popup.nvim'},
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
