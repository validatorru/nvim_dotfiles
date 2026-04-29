return {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
        local intelephense_config = {
            cmd = { 'intelephense', '--stdio' },
            filetypes = { 'php' },
            root_dir = function()
                return vim.uv.cwd()
            end,
            settings = {
                intelephense = {
                    files = {
                        maxSize = 1000000,
                    },
                }
            }
        }
        vim.lsp.enable('intelephense', intelephense_config)
        vim.lsp.enable('laravel_ls')

        local lua_ls_config = {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {
                            'vim',
                            'require'
                        },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }

        vim.lsp.config['lua_ls'] = lua_ls_config
        vim.lsp.enable('lua_ls')

        vim.lsp.enable('pyright')



        -- vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition({})<CR>')
        vim.keymap.set('n', 'K',  '<Cmd>lua vim.lsp.buf.hover({})<CR>')
        -- vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references({})<CR>')
        vim.keymap.set('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename({})<CR>')
        vim.keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action({})<CR>')
    end,
}
