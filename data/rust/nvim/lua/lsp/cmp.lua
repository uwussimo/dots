local ok, cmp = pcall(require, "cmp")

if not ok then
    return
end

local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "⌘",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup {
    confirmation = {
        get_commit_characters = function()
            return {}
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
        keyword_length = 1,
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[LUA]",
                buffer = "[BUFFER]",
                path = "[PATH]",
                vsnip = "[SNIPPET]",
            })[entry.source.name]

            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true),
                    "",
                    true
                )
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true),
                    "",
                    true
                )
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "vsnip" },
        { name = "path" },
        { name = "buffer" },
        { name = "nvim_lsp_signature_help" },
        { name = "emoji" },
    },
    preselect = cmp.PreselectMode.None,
}

cmp.setup.cmdline("/", {
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
