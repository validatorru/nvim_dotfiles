return {
  'ivanesmantovich/xkbswitch.nvim',
    config = function()
      require('xkbswitch').setup()
      -- vim.g.XkbSwitchEnabled = 1
      -- vim.g.XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
    end,
}
