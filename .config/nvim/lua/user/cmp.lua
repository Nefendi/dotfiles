local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

require("luasnip/loaders/from_vscode").lazy_load()

local functions = require "user.functions"

local buffer_fts = {
    "markdown",
    "toml",
    "yaml",
    "json",
}

local compare = require "cmp.config.compare"

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local icons = require "user.icons"

local kind_icons = icons.kind_codicons

vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindPackage", { fg = "#F64D00" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

vim.g.cmp_active = true

cmp.setup {
    enabled = function()
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then
            return false
        end
        return vim.g.cmp_active
    end,
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<S-CR>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = (kind_icons[vim_item.kind] or "") .. "  " .. vim_item.kind

            if entry.source.name == "cmp_tabnine" then
                vim_item.kind = icons.misc.Robot .. "  Suggestion"
                vim_item.kind_hl_group = "CmpItemKindTabnine"
            end

            if entry.source.name == "crates" or entry.source.name == "npm" then
                vim_item.kind = icons.misc.Package .. "  Version"
                vim_item.kind_hl_group = "CmpItemKindPackage"
            end

            if entry.source.name == "emoji" then
                vim_item.kind = icons.misc.SmileyCodicon .. "  Emoji"
                vim_item.kind_hl_group = "CmpItemKindEmoji"
            end

            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                luasnip = "[LuaSnip]",
                buffer = "[Buffer]",
                path = "[Path]",
                emoji = "[CMP]",
                cmp_tabnine = "[Tabnine]",
                crates = "[Crates]",
                npm = "[NPM]",
            })[entry.source.name]

            return vim_item
        end,
    },
    sources = {
        { name = "crates", group_index = 1 },
        { name = "npm", keyword_length = 4, group_index = 1 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "cmp_tabnine", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        {
            name = "buffer",
            group_index = 2,
            filter = function(_, ctx)
                if not functions.contains(buffer_fts, ctx.prev_context.filetype) then
                    return true
                end
            end,
        },
        { name = "path", group_index = 2 },
        { name = "emoji", group_index = 2 },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.sort_text,
            compare.length,
            compare.order,
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
    },
}
