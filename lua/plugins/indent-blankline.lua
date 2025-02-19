return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.g.indent_blankline_show_current_context = true
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#612f33" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#6f5c3b" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#1e374c" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#3d2c1d" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#26321d" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#3a2341" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#142b2e" })
        end)
        require("ibl").setup(
            {
                indent = { highlight = highlight },
                scope = {
                    enabled = true,
                    char = "┃",
                },
            }
        )
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },

}
