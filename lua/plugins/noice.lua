return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- add any options here
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        "hrsh7th/nvim-cmp",
    },


    config = function()
        require("noice").setup({
            views = {
                cmdline_popup = {
                    position = {
                        row = 15,
                        col = "50%",
                    },
                    size = {
                        width = "50%",
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                        padding = { 2, 2 },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
                popupmenu = {
                    enabled = true,
                    relative = "editor",
                    backend = "nui",
                    position = {
                        row = 18,
                        col = "50%",
                    },
                    size = {
                        width = '50%',
                        height = 10,
                    },
                    border = {
                        style = "none",
                        padding = { 4, 2 },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
            },
            messages = {
                -- enabled = true, -- enables the Noice messages UI
                -- view = "notify", -- default view for messages
                -- view_error = "notify", -- view for errors
                -- view_warn = "notify", -- view for warnings
                -- view_history = "messages", -- view for :messages
                -- view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
                enabled = true, -- enables the Noice messages UI
                -- view = "messages", -- default view for messages
                -- view_error = "messages", -- view for errors
                -- view_warn = "messages", -- view for warnings
                -- view_history = "messages", -- view for :messages
                -- view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                -- bottom_search = true, -- use a classic bottom cmdline for search
                -- command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        })
    end,
}
