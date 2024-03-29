-- setup must be called before loading
return {
    'rebelot/kanagawa.nvim',
    config = function()
        require('kanagawa').setup({
            vim.api.nvim_create_autocmd("ColorScheme", {
                desc = "Set custom highlight groups",
                callback = function()
                    if vim.g.colors_name == "gruvbox" then
                        -- set your colors here...
                        vim.api.nvim_set_hl(0, "Normal", { fg = "#FFFFFF", bg = "#000000" })
                    end
                end,
            }),
            compile = true,             -- enable compiling the colorscheme
            undercurl = true,            -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = { italic = true },
            keywordStyle = { italic = true},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true,         -- do not set background color
            dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
            terminalColors = true,       -- define vim.g.terminal_color_{0,17}
            colors = {                   -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            theme = "lotus",              -- Load "wave" theme when 'background' option is not set
            background = {               -- map the value of 'background' option to a theme
                dark = "dragon",           -- try "dragon" !
                light = "lotus"
            },
            overrides = function(colors)
                local theme = colors.theme
                 Visual = {
                  bg = theme.ui.sakuraPink,
                  fg = theme.ui.bg,
                }
                return {
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    NormalFloat = { bg = theme.ui.bg_p2 },
                    NormalBorder = { bg = theme.ui.shade0 },
                    FloatBorder = { bg = theme.ui.bg_m1 },
                    HoverBorder = { bg = theme.ui.shade0 },
                    HoverNormal = { bg = theme.ui.shade0 },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                    -- Normal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                }
            end,
        })

        vim.cmd("colorscheme kanagawa")
    end,
}
