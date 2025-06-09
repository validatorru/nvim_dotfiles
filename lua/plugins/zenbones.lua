return {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
        vim.cmd.colorscheme('kanagawabones')
        darkness = 'stark'
        transparent_background = true
    end
}
