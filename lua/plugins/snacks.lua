return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = true },
        indent = { 
            ---@class snacks.indent.Config
            ---@field enabled? boolean
            indent = {
                priority = 1,
                enabled = true, -- enable indent guides
                -- char = "│",
                char = "┊",
                only_scope = true, -- only show indent guides of the scope
                only_current = false, -- only show indent guides in the current window
                hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
                -- can be a list of hl groups to cycle through
                hl = {
                    "SnacksIndent1",
                    "SnacksIndent2",
                    "SnacksIndent3",
                    "SnacksIndent4",
                    "SnacksIndent5",
                    "SnacksIndent6",
                    "SnacksIndent7",
                },
            },
            -- animate scopes. Enabled by default for Neovim >= 0.10
            -- Works on older versions but has to trigger redraws during animation.
            ---@class snacks.indent.animate: snacks.animate.Config
            ---@field enabled? boolean
            --- * out: animate outwards from the cursor
            --- * up: animate upwards from the cursor
            --- * down: animate downwards from the cursor
            --- * up_down: animate up or down based on the cursor position
            ---@field style? "out"|"up_down"|"down"|"up"
            animate = {
                enabled = vim.fn.has("nvim-0.10") == 1,
                style = "out",
                easing = "linear",
                duration = {
                    step = 50, -- ms per step
                    total = 400, -- maximum duration
                },
            },
            ---@class snacks.indent.Scope.Config: snacks.scope.Config
            scope = {
                enabled = true, -- enable highlighting the current scope
                priority = 200,
                -- char = "│",
                char = "┊",
                underline = true, -- underline the start of the scope
                only_current = false, -- only show scope in the current window
                hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
            },
            chunk = {
                -- when enabled, scopes will be rendered as chunks, except for the
                -- top-level scope which will be rendered as a scope.
                enabled = true,
                -- only show chunk scopes in the current window
                only_current = false,
                priority = 200,
                hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
                char = {
                    -- corner_top = "┌",
                    -- corner_bottom = "└",
                    corner_top = "╭",
                    corner_bottom = "╰",
                    horizontal = "─",
                    -- horizontal = "╌",
                    vertical = "┊",
                    arrow = ">",
                },
            },
            -- filter for buffers to enable indent guides
            ---@param buf number
            ---@param win number
            filter = function(buf, win)
                return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
            end,
        },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        picker = { enabled = false },
        quickfile = { enabled = true },
        scope = { 
            ---@class snacks.scope.Config
            ---@field max_size? number
            ---@field enabled? boolean
            -- absolute minimum size of the scope.
            -- can be less if the scope is a top-level single line scope
            min_size = 2,
            -- try to expand the scope to this size
            max_size = nil,
            cursor = true, -- when true, the column of the cursor is used to determine the scope
            edge = true, -- include the edge of the scope (typically the line above and below with smaller indent)
            siblings = false, -- expand single line scopes with single line siblings
            -- what buffers to attach to
            filter = function(buf)
                return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
            end, -- debounce scope detection in ms
            debounce = 30,
            enabled = true,
            treesitter = {
                -- detect scope based on treesitter.
                -- falls back to indent based detection if not available
                enabled = true,
                injections = true, -- include language injections when detecting scope (useful for languages like `vue`)
                ---@type string[]|{enabled?:boolean}
                blocks = {
                    enabled = false, -- enable to use the following blocks
                    "function_declaration",
                    "function_definition",
                    "method_declaration",
                    "method_definition",
                    "class_declaration",
                    "class_definition",
                    "do_statement",
                    "while_statement",
                    "repeat_statement",
                    "if_statement",
                    "for_statement",
                },
                -- these treesitter fields will be considered as blocks
                field_blocks = {
                    "local_declaration",
                },
            },
            -- These keymaps will only be set if the `scope` plugin is enabled.
            -- Alternatively, you can set them manually in your config,
            -- using the `Snacks.scope.textobject` and `Snacks.scope.jump` functions.
            keys = {
                ---@type table<string, snacks.scope.TextObject|{desc?:string}|false>
                textobject = {
                    ii = {
                        min_size = 2, -- minimum size of the scope
                        edge = false, -- inner scope
                        cursor = false,
                        treesitter = { blocks = { enabled = false } },
                        desc = "inner scope",
                    },
                    ai = {
                        cursor = false,
                        min_size = 2, -- minimum size of the scope
                        treesitter = { blocks = { enabled = false } },
                        desc = "full scope",
                    },
                },
                ---@type table<string, snacks.scope.Jump|{desc?:string}|false>
                jump = {
                    ["[i"] = {
                        min_size = 1, -- allow single line scopes
                        bottom = false,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = { enabled = false } },
                        desc = "jump to top edge of scope",
                    },
                    ["]i"] = {
                        min_size = 1, -- allow single line scopes
                        bottom = true,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = { enabled = false } },
                        desc = "jump to bottom edge of scope",
                    },
                },
            },
        },
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 30, total = 100 },
                easing = "linear",
            },
            -- faster animation when repeating scroll after delay
            animate_repeat = {
                delay = 100, -- delay in ms before using the repeat animation
                duration = { step = 5, total = 50 },
                easing = "linear",
            },
            -- what buffers to animate
            filter = function(buf)
                return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
            end,
        },
        statuscolumn = { enabled = true },
        words = { enabled = false },
        styles = {
            notification = {
                wo = { wrap = true } -- Wrap notifications
            }
        }
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        -- gh
        { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
        { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
        { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
        { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>sr"', function() Snacks.picker.registers() end, desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        -- LSP
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
        { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        -- Other
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        }
    },
    init = function()

        vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#222222" })
        vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#333333" })
        vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#555555" })
        vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#777777" })
        vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#aaaaaa" })
        vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#dddddd" })
        vim.api.nvim_set_hl(0, "SnacksIndent7", { fg = "#ffffff" })

        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end

                -- Override print to use snacks for `:=` command
                if vim.fn.has("nvim-0.11") == 1 then
                    vim._print = function(_, ...)
                        dd(...)
                    end
                else
                    vim.print = _G.dd 
                end

                -- Create some toggle mappings
                -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
                -- Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,
}

