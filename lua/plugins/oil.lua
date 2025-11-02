return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup({
            view_options = {
                show_hidden = true,
            },
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            watch_for_changes = false,
            -- Configuration for the floating window in oil.open_float
            float = {
                -- Padding around the floating window
                padding = 3,
                max_width = 0.7,
                max_height = 0.6,
                border = "none",
                preview_split = "right",
                -- preview_split = "below",
                win_options = {
                    winblend = 2,
                },
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf)
                    vim.cmd("set cc=")
                    return conf
                end,
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-v>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<Esc>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["<SPACE>l"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
            },
            use_default_keymaps = false,
            -- Configuration for the actions floating preview window
            preview_win = {
                -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_width and max_width can be a single value or a list of mixed integer/float types.
                -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                max_width = 0.9,
                -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                min_width = 0.7,
                -- optionally define an integer/float for the exact width of the preview window
                -- width = nil,
                -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_height and max_height can be a single value or a list of mixed integer/float types.
                -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                max_height = 0.9,
                -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                min_height = { 5, 0.1 },
                -- optionally define an integer/float for the exact height of the preview window
                height = nil,
                border = "single",
                win_options = {
                    winblend = 0,
                    wrap = false,
                },
            },
        })
        -- vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
        vim.keymap.set("n", ",-", require("oil").open, { desc = "Open parent directory" })
        -- vim.keymap.set('n', ',-', ':Oil --float <CR>', {})
        vim.keymap.set('n', '-', ':Oil --float <CR>', {})
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
