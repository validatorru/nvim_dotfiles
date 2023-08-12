return {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules", "public", "vendor", "*.min.*"
        }
      },
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = {"png", "webp", "jpg", "jpeg"},
          -- find command (defaults to `fd`)
          find_cmd = "rg"
        },
        aerial = {
          -- Display symbols as <root>.<parent>.<symbol>
          show_nesting = {
            ['_'] = false, -- This key will be the default
            json = true,   -- You can set the option for specific filetypes
            yaml = true,
          }
        },
        }
      })
    local builtin = require('telescope.builtin')
    require('telescope').load_extension('media_files')
    require('telescope').load_extension('http')
    require('telescope').load_extension('coc')
    require('telescope').load_extension('telescope-tabs')
    require('telescope').load_extension('env')
    require('telescope').load_extension('aerial')
    -- Open find files 
    vim.keymap.set('n', ',ff', builtin.find_files, {})
    -- Open text search
    vim.keymap.set('n', ',fg', builtin.live_grep, {})
    --  Open buffers list
    vim.keymap.set('n', ',fb', builtin.buffers, {})
    -- Open tabs list
    vim.keymap.set('n', ',ft', ':Telescope telescope-tabs list_tabs <CR>', {})
    -- Open media files
    vim.keymap.set('n', ',fm', ':Telescope media_files <CR>', {})
    -- Open symbols list
    vim.keymap.set('n', ',fa', ':Telescope aerial <CR>', {})

  end,
  dependencies = {
    {'nvim-lua/plenary.nvim'},
    {'nvim-lua/popup.nvim'},
    {'LinArcX/telescope-env.nvim'},
    {'LukasPietzschmann/telescope-tabs'},
    {'fannheyward/telescope-coc.nvim'},
    {'barrett-ruth/telescope-http.nvim'},
    {'nvim-telescope/telescope-media-files.nvim'},
    {"nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    }
  },
}
