--intelephense
--laravel_ls
--@vue/typescript-plugin
--lua_ls
--vtsls
--vue_ls
--
--
--

return {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
        local lspconfig = require("lspconfig")
        vim.diagnostic.enable(false)

        local intelephense_config = {
            cmd = { 'intelephense', '--stdio' },
            filetypes = { 'php' },
            root_dir = function(fname)
                return vim.loop.cwd()
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
                        -- (most likely LuaJIT in the case of Neovim)
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

        local vue_language_server_path = vim.fn.expand('$MASON/packages')
            .. '/vue-language-server/node_modules/typescript/lib'
        local tsserver_filetypes = {
            'typescript',
            'javascript',
            'javascriptreact',
            'typescriptreact',
            'vue'
        }
        local vue_plugin = {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
            configNamespace = 'typescript',
        }

        local vtsls_config = {
            filetypes = {
                'typescript',
                'javascript',
                'javascriptreact',
                'typescriptreact',
                'vue',
                'html.vue'
            },
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {
                            vue_plugin,
                        },
                        experimental = {
                            completion = {
                                enableServerSideFuzzyMatch = true,
                                entriesLimit = 20,
                            },
                        },
                    },
                },
            },
            -- filetypes = tsserver_filetypes,
        }

        -- local ts_ls_config = {
        --     command = { 'typescript-language-server', '--stdio' },
        --     init_options = {
        --         plugins = {
        --             vue_plugin,
        --         },
        --     },
        --     filetypes = tsserver_filetypes,
        -- }

        -- vim.lsp.config.ts_ls.setup(ts_ls_config)
        -- vim.lsp.enable('ts_ls', ts_ls_config)
        -- vim.lsp.enable('vtsls', vtsls_config)
        vim.lsp.config['vtsls'] = vtsls_config
        vim.lsp.enable('vtsls')
        -- vim.lsp.enable('vue_ls', vtsls_config)
        vim.lsp.enable('vue_ls')

        -- If you are on most recent `nvim-lspconfig`
        -- local vue_ls_config = {}
        -- vim.lsp.config.vue_ls.setup(vue_ls_config)


        -- vim.lsp.enable('vue_ls', {
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     filetypes = { 'vue' },
        --     init_options = {
        --         typescript = {
        --             -- tsdk = vim.fn.expand('$MASON/packages') .. '/vue-language-server/node_modules/typescript/lib'
        --             -- tsdk = '/Users/alexbalaboshko/.local/share/nvim/mason/vue-language-server/node_modules/typescript/lib'
        --             tsdk = '/Users/alexbalaboshko/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib'
        --         }
        --     }
        -- })




        vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
        
        -- Optional: Add more key mappings for better LSP experience
        vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')
        vim.keymap.set('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
        vim.keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
    end,
}
