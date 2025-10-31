return {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    enabled = (jit.os ~= "MacOS"),
    config = function()
        -- vim.cmd.colorscheme('zenbones')
        vim.cmd.colorscheme('zenwritten')
        transparent_background = true
    end
}
