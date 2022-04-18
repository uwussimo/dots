-- Highlight on yank
vim.cmd [[autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}]]

-- Disable comment new line
vim.cmd [[autocmd BufNewFile,BufRead * setlocal formatoptions-=cro]]

--Disable status line in Nvimtree
vim.cmd [[au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif]]
