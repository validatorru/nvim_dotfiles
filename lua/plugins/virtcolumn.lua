return {
    'lukas-reineke/virt-column.nvim',
    config = function()
        require("virt-column").setup(
            {
                -- char = "|" ,
                virtcolumn = "79,120",
                highlight = "ColorColumn"
            }
        )
    end,
}

