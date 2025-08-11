return {
    'lowitea/aw-watcher.nvim',
    config = function()
        require("aw_watcher").setup({
            aw_server = {
                host = "127.0.0.1",
                port = 5600,
                ssl_enable = false,
                pulsetime = 30,
            },
        })
    end,
}

