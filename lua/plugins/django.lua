return {
    {
  "mizisu/django.nvim",
  dependencies = {
    { "folke/snacks.nvim" },
  },
  config = function()
    require("django").setup({})
  end,
}
}
