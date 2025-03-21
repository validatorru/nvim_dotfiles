return {
    'ivanesmantovich/xkbswitch.nvim',
    enabled = (jit.os ~= "Linux"),
    config = function()
        require('xkbswitch').setup()
        -- vim.g.XkbSwitchEnabled = 1
        -- vim.g.XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
    end,
}
