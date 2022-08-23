local ok, wk = pcall(require, "which-key")

if not ok then
    return
end

local opts = {
    mode = "n",
    prefix = "",
    buffer = bufnr,
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
    ["<leader>]"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
    ["<leader>["] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
    ["<leader>q"] = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },

    ["<c-n>"] = { "<cmd>NvimTreeToggle<cr>", "[NVIMTREE] Toggle" },
    ["<leader>r"] = { "<cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Refresh" },

    ["<leader>f"] = {
        name = "[TELESCOPE]",
        f = { "<cmd>Telescope find_files hidden=true<cr>", "[TELESCOPE] Find File" },
        g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by grep" },
        b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags" },
        m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
    },

    ["<leader>x"] = {
        name = "[TROUBLE]",
        x = { "<cmd>Trouble<cr>", "[TROUBLE] Show trouble list" },
        w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "[TROUBLE] Show LSP workspace diagnostic" },
        d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "[TROUBLE] Show LSP document diagnostic" },
        l = { "<cmd>Trouble loclist<cr>", "[TROUBLE] Locklist" },
        q = { "<cmd>Trouble quickfix<cr>", "[TROUBLE] Quick fix" },
        r = { "<cmd>Trouble lsp_references<cr>", "[TROUBLE] References" },
    },

    ["<leader>l"] = {
        name = "[LSP]",
        n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "[SAGA] Diagnostic jump next" },
        p = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "[SAGA] Diagnostic jump previous" },
        d = { "<cmd>Lspsaga preview_definition<cr>", "[SAGA] Preview definition" },
        x = { "<cmd>Lspsaga lsp_finder<cr>", "[SAGA] LSP Finder" },
        c = { "<cmd>Lspsaga code_action<cr>", "[SAGA] Code Action" },
        r = { "<cmd>Lspsaga rename<cr>", "[SAGA] Rename" },
    },

    ["<leader>g"] = {
        name = "[GITSIGNS]",
        s = { "<cmd>Gitsigns toggle_signs<cr>", "[GITSIGNS] Toggle signs" },
        h = { "<cmd>Gitsigns preview_hunk<cr>", "[GITSIGNS] Preview hunk" },
        d = { "<cmd>Gitsigns diffthis<cr>", "[GITSIGNS] Show diff" },
    },
}, opts)

wk.setup {}
