local ok, lsp_config = pcall(require, "lspconfig")
local ok_wk, wk = pcall(require, "which-key")
if not ok then
    return
end

local lsp_installer = require "nvim-lsp-installer"
local utils = require "utils"

local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    local is_null_ls = client.name == "null-ls"
    client.resolved_capabilities.document_formatting = is_null_ls
    client.resolved_capabilities.document_range_formatting = is_null_ls

    -- LSP Keymaps
    if ok_wk then
        wk.register({
            ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "[LSP] Show declaration" },
            ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "[LSP] Show definition" },
            ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "[LSP] Hover" },
            ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "[LSP] Show implementation" },
            ["<leader>lh"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "[LSP] Show Signature help" },

            ["<leader>w"] = {
                name = "[WORKSPACE]",
                a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "[WORKSPACE] Add folder" },
                r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "[WORKSPACE] Remove folder" },
                l = {
                    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    "[WORKSPACE] Show list folder",
                },
            },

            ["<leader>lD"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "[LSP] Show type definition" },
            ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "[LSP] Show references" },
            ["<leader>lf"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "[LSP] Formatting" },
        }, {
            mode = "n",
            prefix = "",
            buffer = bufnr,
            silent = true,
            noremap = true,
            nowait = true,
        })
    else
        local opts = { noremap = true, silent = true }

        vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>h", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<space>wl",
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            opts
        )
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 0,
        },
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
    }

    if server.name == "sumneko_lua" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                    disable = {
                        "lowercase-global",
                        "undefined-global",
                        "unused-local",
                        "unused-function",
                        "unused-vararg",
                        "trailing-space",
                    },
                },
            },
        }
    end

    if server.name == "emmet_ls" then
        opts.root_dir = function(fname)
            return vim.loop.cwd()
        end
    end

    server:setup(opts)
end)

-- Gutter sign icons
for type, icon in pairs(utils.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Diagnostics icons right side of code
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
        spacing = 6,
        prefix = " ",
    },
    signs = true,
    underline = false,
    update_in_insert = false,
})
