local _M = {}

_M.powerline = {
    circle = {
        left = "",
        right = "",
    },
    arrow = {
        left = "",
        right = "",
    },
    triangle = {
        left = "",
        right = "",
    },
}

function _M.getOutputFromOsCommand(cmd)
    local handle = assert(io.popen(cmd, "r"))
    local output = assert(handle:read "*a")

    handle:close()

    return (output:gsub("^%s*(.-)%s*$", "%1"))
end

_M.signs = { Error = "", Warn = "", Hint = "", Info = "" }

function _M.setSpacesSize(filetypes)
    for filetype, size in pairs(filetypes) do
        vim.cmd(string.format("autocmd FileType %s set sw=%s", filetype, size))
        vim.cmd(string.format("autocmd FileType %s set ts=%s", filetype, size))
        vim.cmd(string.format("autocmd FileType %s set sts=%s", filetype, size))
    end
end

return _M
