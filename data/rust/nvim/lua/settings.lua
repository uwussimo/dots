vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.cmd [[set fcs=eob:\ ]]
vim.cmd [[filetype plugin indent on]]

local options = {
    termguicolors = true,
    fileencoding = "utf-8",
    backup = false,
    swapfile = false,
    hlsearch = true,
    showmode = false,
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    scrolloff = 8,
    sidescrolloff = 8,
    smartindent = true,
    signcolumn = "yes",
    hidden = true,
    ignorecase = true,
    timeoutlen = 1000,
    shiftround = true,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    number = true,
    relativenumber = true,
    clipboard = "unnamedplus",
    cursorline = true,
    mouse = "a",
    cmdheight = 1,
    undodir = os.getenv "HOME" .. "/.nvimdid",
    undofile = true,
    pumheight = 10,
}

vim.opt.shortmess:append "c"

for key, value in pairs(options) do
    vim.opt[key] = value
end

require("utils").setSpacesSize { go = 4, python = 4, rust = 4, cpp = 4, c = 4 }
require("theme").detectTheme()

vim.g.nvim_markdown_preview_format = "gfm"
vim.g.nvim_markdown_preview_theme = "github"

vim.cmd [[command! Format lua vim.lsp.buf.formatting()]]
