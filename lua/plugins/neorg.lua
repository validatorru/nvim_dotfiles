return {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond",
                    }
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            work = "~/Documents/Personal/writings/notes/work",
                            home = "~/Documents/Personal/writings/notes/personal",
                        }
                    }
                }
            }
        }
    end,
}
