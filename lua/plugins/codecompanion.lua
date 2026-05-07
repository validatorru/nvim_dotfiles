return {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("codecompanion").setup({
            -- // Enable lmstudio models by declaring them in the adapters block inside the http block
            adapters = {
                http = {
                    lmstudio = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            name = "lmstudio",
                            env = {
                                url = "http://localhost:1234",
                                api_key = "asdfsdf",
                            },
                            schema = {
                                model = {
                                    default = "liquid/lfm2.5-1.2b",
                                },
                            },
                        })
                    end,
                },
            },
            strategies = {
                chat = {
                    adapter = "lmstudio",
                },
                inline = {
                    adapter = "lmstudio",
                },
                agent = {
                    adapter = "lmstudio",
                },
            },
        })
        -- Optional keybindings
        vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
        vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanion <cr>", { desc = "Inline Assistant" })
    end,
}
