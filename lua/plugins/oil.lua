return {
  'stevearc/oil.nvim',
    config = function()
      require('oil').setup({})
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
