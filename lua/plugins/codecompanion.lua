return {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = {
                        name = "ollama",
                        -- model = "mistral",
                        model = "deepseek-r1:8b",
                    },
                },
                inline = {
                    adapter = {
                        name = "ollama",
                        -- model = "deepcoder:1.5b",
                        model = "deepseek-r1:8b",
                    },
                },
            },
        })
    end
}
