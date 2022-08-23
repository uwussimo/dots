local utils = require "utils"
local _M = {}

local gruvbox_dark = {
    bg = "#282828",
    bg1 = "#3c3836",
    bg2 = "#504945",
    bg3 = "#665c54",
    fg = "#ebdbb2",
    fg1 = "#d5c4a1",
    white = "#fbf1c7",
    black = "#282828",
    orange = "#d65d0e",
    yellow = "#d97721",
    red = "#cc241d",
    blue = "#458588",
    green = "#98971a",
    cyan = "#689d6a",
    magenta = "#b16286",
    pink = "#b16286",
}

local gruvbox_light = {
    bg = "#ebdbb2",
    bg1 = "#ebdbb2",
    bg2 = "#bdae93",
    bg3 = "#a89984",
    bg4 = "#928374",
    fg = "#282828",
    fg1 = "#3c3836",
    white = "#282828",
    black = "#fbf1c7",
    orange = "#d65d0e",
    yellow = "#d97721",
    red = "#cc241d",
    blue = "#458588",
    green = "#98971a",
    cyan = "#689d6a",
    magenta = "#b16286",
    pink = "#b16286",
}

local nord = {
    bg = "#2e3440",
    bg1 = "#3b4252",
    bg2 = "#262b36",
    bg3 = "#4c566a",
    fg = "#e5e9f0",
    fg1 = "#707788",
    red = "#bf616a",
    white = "#a5abb8",
    black = "#222733",
    orange = "#d08770",
    yellow = "#ebcb8b",
    blue = "#5e81ac",
    green = "#a3be8c",
    cyan = "#88c0d0",
    magenta = "#b48ead",
    pink = "#FFA19F",
}

local nord_light = {
    bg = "#ECEFF4",
    bg1 = "#E5E9F0",
    bg2 = "#E5E9F0",
    bg3 = "#E5E9F0",
    fg = "#3B4252",
    fg1 = "#707788",
    red = "#bf616a",
    white = "#a5abb8",
    black = "#D8DEE9",
    orange = "#d08770",
    yellow = "#ebcb8b",
    blue = "#5e81ac",
    green = "#a3be8c",
    cyan = "#88c0d0",
    magenta = "#b48ead",
    pink = "#FFA19F",
}

function _M.detectTheme()
    local currentKittyTheme = utils.getOutputFromOsCommand "cat ~/.config/kitty/kitty.conf | grep 'include ./colors/'"

    if currentKittyTheme == "include ./colors/gruvbox-dark.conf" then
        _M.colors = gruvbox_dark
        vim.g.gruvbox_italic = 1
        vim.g.gruvbox_bold = 1
        vim.g.gruvbox_contrast_dark = "hard"
        vim.opt.background = "dark"
        vim.cmd [[colorscheme gruvbox]]
    elseif currentKittyTheme == "include ./colors/gruvbox-light.conf" then
        vim.g.gruvbox_italic = 1
        vim.g.gruvbox_bold = 1
        vim.g.gruvbox_contrast_light = "soft"
        _M.colors = gruvbox_light
        vim.opt.background = "light"
        vim.cmd [[colorscheme gruvbox]]
    elseif currentKittyTheme == "include ./colors/nord-light.conf" then
        _M.colors = nord_light
        vim.opt.background = "light"
        _M.colors = nord_light
        local isExistNord, onenord = pcall(require, "onenord")

        if isExistNord then
            onenord.setup {
                borders = true,
                fade_nc = false,
                styles = {
                    comments = "italic",
                    strings = "NONE",
                    keywords = "NONE",
                    functions = "italic",
                    variables = "bold",
                    diagnostics = "underline",
                },

                disable = {
                    background = true,
                    cursorline = false,
                    eob_lines = true,
                },
                custom_highlights = {
                    NvimTreeNormal = { fg = _M.colors.fg, bg = _M.colors.bg },
                    WhichKeyFloat = { bg = _M.colors.bg2 },
                },
            }
        end
    else
        vim.opt.background = "dark"
        _M.colors = nord
        local isExistNord, onenord = pcall(require, "onenord")

        if isExistNord then
            onenord.setup {
                borders = true,
                fade_nc = true,
                styles = {
                    comments = "italic",
                    strings = "NONE",
                    keywords = "NONE",
                    functions = "italic",
                    variables = "bold",
                    diagnostics = "underline",
                },
                disable = {
                    background = true,
                    cursorline = false,
                    eob_lines = true,
                },
                custom_highlights = {
                    NvimTreeNormal = { fg = _M.colors.fg, bg = _M.colors.bg },
                    WhichKeyFloat = { bg = _M.colors.bg2 },
                },
            }
        end
    end
end

return _M
