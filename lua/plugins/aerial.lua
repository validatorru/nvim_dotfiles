return {
  'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup({})
      -- Set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
}
