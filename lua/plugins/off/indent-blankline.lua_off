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
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_tab_indent_level
        )
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.g.indent_blankline_show_current_context = true
            -- Quite nice colors, but too much hue
            -- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#612f33" })
            -- vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#6f5c3b" })
            -- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#1e374c" })
            -- vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#3d2c1d" })
            -- vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#26321d" })
            -- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#3a2341" })
            -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#142b2e" })

            -- Monocrome version
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#222222" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#333333" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#555555" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#777777" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#aaaaaa" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#dddddd" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#ffffff" })
        end)
        require("ibl").setup(
            {
                indent = {
                    highlight = highlight,
                    char = "┊",
                    smart_indent_cap = true,
                },
                scope = {
                    enabled = true,
                    highlight = highlight,
                    show_start = true,
                    show_end = true,
                    injected_languages = false,
                },
            }
        )
    end
}
