return {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
    local lspconfig = require("lspconfig")
    vim.diagnostic.enable(false)

    local intelephense_config = {
        cmd = { 'intelephense', '--stdio' };
        filetypes = { 'php' };
        root_dir = function(fname)
            return vim.loop.cwd()
        end;
        settings = {
            intelephense = {
                files = {
                    maxSize = 1000000;
                };
            }
        }
    }
    vim.lsp.enable('intelephense')
    -- vim.lsp.enable('phpactor')


    -- vim.lsp.enable('laravel_ls')


    local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
    local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
    local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
    }
    local vtsls_config = {
        settings = {
            vtsls = {
                tsserver = {
                    globalPlugins = {
                        vue_plugin,
                    },
                },
            },
        },
        filetypes = tsserver_filetypes,
    }

    local ts_ls_config = {
        init_options = {
            plugins = {
                vue_plugin,
            },
        },
        filetypes = tsserver_filetypes,
    }
    vim.lsp.config('ts_ls', ts_ls_config)
    vim.lsp.enable({'ts_ls'})
    vim.lsp.enable({'vue_ls'})

    -- If you are on most recent `nvim-lspconfig`
    local vue_ls_config = {}
    vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    intelephense = function ()
        require('lspconfig').intelephense.setup({
            root_dir = function ()
                return vim.loop.cwd()
            end,
        })
    end
    end,
    }
