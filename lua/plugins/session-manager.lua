return {
  'Shatur/neovim-session-manager',
    config = function()
      require('session_manager').setup({})
    end,
  -- Optional dependencies
  dependencies = { "nvim-lua/plenary.nvim" },
}

