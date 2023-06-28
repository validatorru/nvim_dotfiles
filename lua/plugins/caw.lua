return {
    'tyru/caw.vim',
    version = "*",
    config = function()
        --vim.keymap.set('n', 'gcc', ':call nerdcommenter#Comment(0, "toggle")<CR>')
    end,
    dependencies = { "Shougo/context_filetype.vim" },
}
