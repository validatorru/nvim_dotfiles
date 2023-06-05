return {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
    config = function()
      require('telescope').setup({})
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', ',ff', builtin.find_files, {})
      vim.keymap.set('n', ',fg', builtin.live_grep, {})
      vim.keymap.set('n', ',fb', builtin.buffers, {})
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
}
