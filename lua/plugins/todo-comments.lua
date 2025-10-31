return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        FIX = {
            alt = {
                "fixme",
                "bug",
                "fixit",
                "issue",
                "Fixme",
                "Bug",
                "Fixit",
                "Issue"
            }, 
        },
        TODO = {
            alt = {
                "Todo",
                "todo"
            }, 
        },
        HACK = {},
        WARN = {},
        PERF = {},
        NOTE = {
            alt = {
                "Memo",
                "Info",
                "NB",
                "Note",
                "note"
            },
        },
        TEST = {},
    }
}
