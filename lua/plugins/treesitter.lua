
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

      vim.api.nvim_create_autocmd('FileType', {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          local configs = require('nvim-treesitter.parsers')
        end,
      })

      nts.setup(opts)
      nts.install(parsers)

      -- map('n', '<leader>it', vim.treesitter.inspect_tree)
      -- map('n', '<leader>i', vim.show_pos)
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

-- return {
--     "nvim-treesitter/nvim-treesitter",
--     version = "main", -- last release is way too old and doesn't work on Windows
--     lazy = false,
--     build = ":TSUpdate",
--
--     -- event = { "BufReadPost", "BufNewFile" },
--     dependencies = {
--         {
--             "nvim-treesitter/nvim-treesitter-textobjects",
--             init = function()
--                 -- PERF: no need to load the plugin, if we only need its queries for mini.ai
--                 local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
--                 local opts = require("lazy.core.plugin").values(plugin, "opts", false)
--                 local enabled = false
--                 if opts.textobjects then
--                     for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
--                         if opts.textobjects[mod] and opts.textobjects[mod].enable then
--                             enabled = true
--                             break
--                         end
--                     end
--                 end
--                 if not enabled then
--                     require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
--                 end
--             end,
--         },
--     },
--     keys = {
--         { "<c-space>", desc = "Increment selection" },
--         { "<bs>", desc = "Decrement selection", mode = "x" },
--     },
--     ---@type TSConfig
--     opts = {
--         highlight = {
--             enable = true,
--             additional_vim_regex_highlighting = false,
--             -- disable = function(_, bufnr)
--             --     -- Return true if the buffer is a minified file or if its size is too large.
--             -- end,
--         },
--         indent = { enable = true },
--         -- ensure_installed = {
--         --     "bash",
--         --     "blade",
--         --     "c",
--         --     "html",
--         --     "html_tags",
--         --     "javascript",
--         --     "json",
--         --     "lua",
--         --     "luadoc",
--         --     "luap",
--         --     "markdown",
--         --     "markdown_inline",
--         --     "python",
--         --     "php",
--         --     "php_only",
--         --     "query",
--         --     "regex",
--         --     "tsx",
--         --     "typescript",
--         --     "vim",
--         --     "vimdoc",
--         --     "yaml",
--         --     "vue",
--         -- },
--         incremental_selection = {
--             enable = true,
--             keymaps = {
--                 init_selection = "<C-space>",
--                 node_incremental = "<C-space>",
--                 scope_incremental = false,
--                 node_decremental = "<bs>",
--             },
--         },
--     },
--     ---@param opts TSConfig
--     config = function(_, opts)
--         if type(opts.ensure_installed) == "table" then
--             ---@type table<string, boolean>
--             local added = {}
--             opts.ensure_installed = vim.tbl_filter(function(lang)
--                 if added[lang] then
--                     return false
--                 end
--                 added[lang] = true
--                 return true
--             end, opts.ensure_installed)
--         end
--         -- require("nvim-treesitter.configs").setup(opts)
--     --     require("nvim-treesitter.configs").setup(opts)
--     --     local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
--     --
--     --     parser_config.blade = {
--     --         install_info = {
--     --             url = "https://github.com/EmranMR/tree-sitter-blade",
--     --             files = {"src/parser.c"},
--     --             branch = "main",
--     --         },
--     --         filetype = "blade"
--     --     }
--     -- end,
--     require('render-markdown').setup({ latex = { enabled = false } })
--     -- Temporarily add this debug code to your config:
--
--     ---@param opts TSConfig
--     -- config = function(_, opts)
--     --     -- Ensure treesitter is loaded before requiring its configs module
--     --     require("nvim-treesitter.install").prefer_git = true
--     --
--     --     -- Remove duplicates from ensure_installed (optional cleanup)
--     --     local added = {}
--     --     if type(opts.ensure_installed) == "table" then
--     --         opts.ensure_installed = vim.tbl_filter(function(lang)
--     --             if added[lang] then
--     --                 return false
--     --             end
--     --             added[lang] = true
--     --             return true
--     --         end, opts.ensure_installed)
--     --     end
--     --
--     --     -- Setup treesitter
--     --     -- require("nvim-treesitter.configs").setup(opts)
--     --     require("nvim-treesitter").setup(opts)
--     --     require('render-markdown').setup({
--     --         html = { enabled = false },
--     --         yaml = { enabled = false }
--     --     })
--     --
--     --     -- Optional: Add custom parser for Blade if needed
--     --     -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
--     --     -- parser_config.blade = {
--     --     --     install_info = {
--     --     --         url = "https://github.com/EmranMR/tree-sitter-blade",
--     --     --         files = {"src/parser.c"},
--     --     --         branch = "main",
--     --     --     },
--     --     --     filetype = "blade"
--     --     -- }
--     end,
--
-- }
