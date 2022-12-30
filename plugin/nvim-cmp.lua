local status_ok, cmp, luasnip

status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
    print("Failed to require cmp")
    return
end

status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    print("Failed to require luasnip")
    return
end


require("luasnip/loaders/from_snipmate").lazy_load()


local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup({

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    --[[ window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }, ]]

    mapping = cmp.mapping.preset.insert({

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.


        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" })

    }),


    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, 30)
            if truncated_label ~= label then
                vim_item.abbr = truncated_label .. "..."
            end
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[NVIM_LUA]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },

    sources = {
        { name = 'nvim_lsp', priority = 15, keyword_length = 4, max_item_count = 4 },
        { name = 'luasnip', priority = 5, keyword_length = 3 },
        { name = 'buffer', priority = 0, keyword_length = 4 },
        { name = 'path', priority = -5 },
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
})


cmp.setup.filetype("lua", {
    sources = {
        { name = 'nvim_lua', priority = 20 },
        { name = 'nvim_lsp', priority = 15, keyword_length = 4, max_item_count = 4 },
        { name = 'buffer', priority = 10 },
        { name = 'luasnip', priority = 100 },
        { name = 'path', priority = -5 },
    }
})

cmp.setup.filetype("cpp", {
    sources = {
        { name = 'luasnip', priority = 100, keyword_length = 3 },
        { name = 'nvim_lsp', priority = 15, keyword_length = 4, max_item_count = 4 },
        { name = 'buffer', priority = 5, keyword_length = 4 },
        { name = 'path', priority = -5 },
    }
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer', keyword_length = 4 }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'cmdline', priority = 10 },
        { name = 'path', keyword_length = 4 },
    }
})
