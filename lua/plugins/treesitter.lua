
local parsers = {
    'bash',
    'blade',
    'c',
    'comment',
    'cpp',
    'css',
    'csv',
    'devicetree',
    'diff',
    'ebnf',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'html',
    'ini',
    'javascript',
    'json',
    'json5',
    'jsdoc',
    'latex',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'markdown_inline',
    'mermaid',
    'ocaml',
    'passwd',
    'php',
    'php_only',
    'phpdoc',
    'python',
    'regex',
    'tsx',
    'typescript',
    'query',
    'regex',
    'rust',
    'sql',
    'ssh_config',
    'toml',
    'twig',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
}

---@type LazySpec
return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        opts = {},
        config = function(_, opts)
            local nts = require('nvim-treesitter')
            nts.setup(opts)
            nts.install(parsers)
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {},
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        opts = {
            select = {
                lookahead = true,
                keymaps = {
                    ['if'] = '@function.inner',
                    ['af'] = '@function.outer',
                    ['ic'] = '@class.inner',
                    ['ac'] = '@class.outer',
                    ['il'] = '@loop.inner',
                    ['al'] = '@loop.outer',
                    ['ia'] = '@parameter.inner',
                    ['aa'] = '@parameter.outer',
                },
            },
        },
    },
    {
        'windwp/nvim-ts-autotag',
        enabled = false, -- this breaks dot repeating with `>`
        opts = {
            enable_close_on_slash = true,
        },
    },
}
