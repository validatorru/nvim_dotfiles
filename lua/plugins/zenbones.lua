return {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    enabled = (jit.os ~= "MacOS"),
    config = function()
        vim.cmd.colorscheme('zenbones')
        -- vim.cmd.colorscheme('zenwritten')
        -- vim.cmd.colorscheme('neobones')
        darkness = 'stark'
        transparent_background = true
    end
}
