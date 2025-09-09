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

header_banner_placeholder = {
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
}
header_banner_img_src = "~/documents/tmp/banner1.png"
header_banner_img = vim.fn.system("chafa ~/documents/tmp/banner1.png")

quotation = vim.fn.system("fortune")

-------------------
-------------------
---  Image rendering code taken from 
---  https://github.com/goolord/alpha-nvim/discussions/16
---  and in particular:
---  https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-12190458
---
---
---
---
---
---
-------------------
-------------------


-- Image Integration
local image = nil

local keywords = {"1", "2", "3"}

local image_path = vim.fn.expand("~/Documents/tmp/banner1.png") -- Change to your image path
-- local paths = io.popen("find ~/Documents/tmp/banner -type f \\( -iname '*.jpg' -o -iname '*.png' \\)", "r")
local paths = io.popen("find ~/Documents/tmp/banner* -type f", "r")
local imgs = {}
for l in assert(paths):lines() do
    for _,k in pairs(keywords) do
        if string.match(l,k) then
            table.insert(imgs, l)
            break
        end
    end
end
assert(paths):close()
local image_width = 50
local image_height = 30


local image_path = imgs[math.random(#imgs)]
-- local image_path = imgs[math.random(3)]
local dim = assert(io.popen("magick identify -ping -format '%w\n%h' " .. image_path))
local i_width, i_height = dim:read("*n", "*n")
i_width, i_height = i_width or image_width, i_height or image_width
if(i_width*0.75) < i_height then
    image_width = math.ceil(i_width/i_height*image_height)
end
-- vim.notify(image_path)
vim.api.nvim_create_autocmd("User", {
    pattern = "AlphaReady",
    desc = "Render an image on the dashboard",
    callback = function()
        vim.go.laststatus = 0
        vim.opt.showtabline = 0

        local buf = vim.api.nvim_get_current_buf()
        local win = vim.api.nvim_get_current_win()
        local win_width = vim.api.nvim_win_get_width(win)

        local col = math.floor(win_width / 1.4) - math.floor(image_width / 2)

        -- Delay rendering so the image doesn't slow startup
        vim.defer_fn(function()
            if vim.api.nvim_get_current_buf() ~= buf then return end
            image = require("image").from_file(imgs[math.random(#imgs)], {
                window = win,
                buffer = buf,
                width = image_width * 1.5,
                height = image_height * 1.5,
                inline = true,
                x = 0,
                y = 0,
                with_virtual_padding = false,
                id = image_path
            })
            local old_max_height_window_percentage = image.global_state.options.max_height_window_percentage
            image.global_state.options.max_height_window_percentage = 75
            image:brightness(90)
            image:render({
                x = 100,
                y = 0,
            })
            image.global_state.options.max_height_window_percentage = old_max_height_window_percentage
        end, 150)
    end,
})

vim.api.nvim_create_autocmd("BufUnload", {
    buffer = 0,
    desc = "Cleanup image when leaving alpha",
    callback = function()
        vim.go.laststatus = 3
        vim.opt.showtabline = 2
        if image then image:clear() end
    end,
})

-------------------
-------------------
---
---
---
---
---
---
---
-------------------

for line in string.gmatch(quotation, "[^\n]+") do
    table.insert(header_banner_placeholder, line)
end

return {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        local startify = require'alpha.themes.startify'
        startify.section.header.val = header_banner_placeholder
        -- startify.section.header.val = header_banner_img_src
        require'alpha'.setup(startify.opts)
        require'alpha'.setup(startify.config)
    end,
}
