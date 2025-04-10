return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
        provider = "deepseek",
        vendors = {
            deepseek = {
                __inherited_from = "openai",
                api_key_name = "OPENAI_API_KEY",
                endpoint = "https://api.deepseek.com",
                model = "deepseek-coder",
                -- model = "deepseek-chat", -- your desired model (or use gpt-4o, etc.)
                max_tokens = 8192,
            },
            openai = {
                api_key_name = "OPENAI_API_KEY",
                model = "gpt-4",
                max_tokens = 4096,
            },
            copilot = {
                api_key_name = "COPILOT_API_KEY",
                model = "copilot",
            },
        },
        keybindings = {
            toggle = ",aa", -- Toggle Avante UI (changed from `<leader>aa`)
            -- ask = ",aq",    -- Ask Avante a question (unchanged)
            insert = ",ai", -- Insert AI-generated text (changed from `<leader>ai`)
        },
    },
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",

        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = true, -- Enable base64 embedding for better compatibility
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },

                    use_absolute_path = true,
                },
            },
        },
        {

            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
                render = {
                    highlight = true, -- Enable syntax highlighting
                    toc = true,       -- Enable table of contents
                },
            },
            ft = { "markdown", "Avante" },
        },
    },
    config = function(_, opts)
        require("avante").setup(opts)
        -- Additional setup for keybindings
        vim.keymap.set("n", opts.keybindings.toggle, function()
            require("avante").toggle()
        end, { desc = "Toggle Avante UI" })
        vim.keymap.set("n", opts.keybindings.ask, function()
            require("avante").ask()
        end, { desc = "Ask Avante a question" })
        vim.keymap.set("n", opts.keybindings.insert, function()
            require("avante").insert()
        end, { desc = "Insert AI-generated text" })
    end,
}
