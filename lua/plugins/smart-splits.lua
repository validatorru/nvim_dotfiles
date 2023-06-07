return {
    'mrjones2014/smart-splits.nvim',
    config = function()
        require('smart-splits').setup({
            -- Ignored filetypes (only while resizing)
            ignored_filetypes = {
                'nofile',
                'quickfix',
                'prompt',
            },
        })
    end,
}
