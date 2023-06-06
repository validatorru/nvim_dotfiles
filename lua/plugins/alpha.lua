header_banner = {
    [[  .d8888b.                             d8b      888                                                   888                      888    ]], 
    [[ d88P  Y88b                            Y8P      888                                                   888                      888    ]], 
    [[ 888    888                                     888                                                   888                      888    ]], 
    [[ 888         .d88b.  88888b.  .d8888b  888  .d88888  .d88b.  888d888        .d8888b  .d88b.  88888b.  888888  .d88b.  888  888 888888 ]], 
    [[ 888        d88""88b 888 "88b 88K      888 d88" 888 d8P  Y8b 888P"         d88P"    d88""88b 888 "88b 888    d8P  Y8b `Y8bd8P' 888    ]], 
    [[ 888    888 888  888 888  888 "Y8888b. 888 888  888 88888888 888           888      888  888 888  888 888    88888888   X88K   888    ]], 
    [[ Y88b  d88P Y88..88P 888  888      X88 888 Y88b 888 Y8b.     888           Y88b.    Y88..88P 888  888 Y88b.  Y8b.     .d8""8b. Y88b.  ]], 
    [[  "Y8888P"   "Y88P"  888  888  88888P' 888  "Y88888  "Y8888  888            "Y8888P  "Y88P"  888  888  "Y888  "Y8888  888  888  "Y888 ]],
    [[  ]],
}

quotation = vim.fn.system("fortune")

for line in string.gmatch(quotation, "[^\n]+") do
    table.insert(header_banner, line)
end

return {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        local startify = require'alpha.themes.startify'
        startify.section.header.val = header_banner
        require'alpha'.setup(startify.opts)
        require'alpha'.setup(startify.config)
    end,
}
