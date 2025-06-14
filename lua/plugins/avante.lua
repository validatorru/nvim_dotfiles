return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
        provider = "openai",
        providers = {
            openai = {
                vendors = {
                    openai = {
                        __inherited_from = "openai",
                        api_key_name = "OPENAI_API_KEY",
                        endpoint = "https://api.deepseek.com",
                        model = "deepseek-chat", -- your desired model (or use gpt-4o, etc.)
                        max_tokens = 8192
                    },
                },
            },
        },
        -- This is snail slow and buggy for some reason  
        -- provider = "ollama",
        -- providers = {
        --     ollama = {
        --         endpoint = "127.0.0.1:11434",
        --         model = "qwen2.5-coder:7b",
        --         extra_request_body = {
        --             options = {
        --                 keep_alive = false,
        --             }
        --         }
        --     },
        -- },
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
    },
    config = function(_, opts)
        require("avante").setup(opts)
        -- Additional setup for keybindings
        -- vim.keymap.set("n", opts.keybindings.toggle, function()
        --     require("avante").toggle()
        -- end, { desc = "Toggle Avante UI" })
        -- vim.keymap.set("n", opts.keybindings.ask, function()
        --     require("avante").ask()
        -- end, { desc = "Ask Avante a question" })
        -- vim.keymap.set("n", opts.keybindings.insert, function()
        --     require("avante").insert()
        -- end, { desc = "Insert AI-generated text" })
    end,
}
