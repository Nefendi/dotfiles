local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local icons = require "user.icons"
local kind_icons = icons.kind

local cmp_mapping = require "cmp.config.mapping"
local cmp_types = require "cmp.types.cmp"

local ConfirmBehavior = cmp_types.ConfirmBehavior
local SelectBehavior = cmp_types.SelectBehavior

local confirm_opts = {
    behavior = ConfirmBehavior.Replace,
    select = false,
}

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function jumpable(dir)
    local win_get_cursor = vim.api.nvim_win_get_cursor
    local get_current_buf = vim.api.nvim_get_current_buf

    local function seek_luasnip_cursor_node()
        if not luasnip.session.current_nodes then
            return false
        end

        local node = luasnip.session.current_nodes[get_current_buf()]
        if not node then
            return false
        end

        local snippet = node.parent.snippet
        local exit_node = snippet.insert_nodes[0]

        local pos = win_get_cursor(0)
        pos[1] = pos[1] - 1

        -- exit early if we're past the exit node
        if exit_node then
            local exit_pos_end = exit_node.mark:pos_end()
            if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        node = snippet.inner_first:jump_into(1, true)
        while node ~= nil and node.next ~= nil and node ~= snippet do
            local n_next = node.next
            local next_pos = n_next and n_next.mark:pos_begin()
            local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
                or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

            -- Past unmarked exit node, exit early
            if n_next == nil or n_next == snippet.next then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end

            if candidate then
                luasnip.session.current_nodes[get_current_buf()] = node
                return true
            end

            local ok
            ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
            if not ok then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        -- No candidate, but have an exit node
        if exit_node then
            -- to jump to the exit node, seek to snippet
            luasnip.session.current_nodes[get_current_buf()] = snippet
            return true
        end

        -- No exit node, exit from snippet
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil
        return false
    end

    if dir == -1 then
        return luasnip.in_snippet() and luasnip.jumpable(-1)
    else
        return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
    end
end

vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindPackage", { fg = "#F64D00" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

vim.g.cmp_active = true

local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
}

local source_names = {
    nvim_lsp = "(LSP)",
    nvim_lua = "(Lua)",
    emoji = "(Emoji)",
    path = "(Path)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    crates = "(Crates)",
    npm = "(NPM)",
    copilot = "(Copilot)",
}

local duplicates_default = 0

local max_width = 0

cmp.setup {
    enabled = function()
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then
            return false
        end
        return vim.g.cmp_active
    end,
    preselect = cmp.PreselectMode.Item,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
        ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = SelectBehavior.Select }, { "i" }),
        ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = SelectBehavior.Select }, { "i" }),
        ["<C-d>"] = cmp_mapping.scroll_docs(-4),
        ["<C-f>"] = cmp_mapping.scroll_docs(4),
        ["<C-y>"] = cmp_mapping {
            i = cmp_mapping.confirm { behavior = ConfirmBehavior.Replace, select = false },
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm { behavior = ConfirmBehavior.Replace, select = false }
                else
                    fallback()
                end
            end,
        },
        ["<Tab>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif jumpable(1) then
                luasnip.jump(1)
            elseif has_words_before() then
                -- cmp.complete()
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp_mapping.complete(),
        ["<C-e>"] = cmp_mapping.abort(),
        ["<CR>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
                local conf_opts = vim.deepcopy(confirm_opts) -- avoid mutating the original opts below

                local is_insert_mode = function()
                    return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
                end

                if is_insert_mode() then -- prevent overwriting brackets
                    conf_opts.behavior = ConfirmBehavior.Insert
                end

                local entry = cmp.get_selected_entry()
                local is_copilot = entry and entry.source.name == "copilot"

                if is_copilot then
                    conf_opts.behavior = ConfirmBehavior.Replace
                    conf_opts.select = true
                end

                if cmp.confirm(conf_opts) then
                    return -- success, exit early
                end
            end

            fallback() -- if not exited early, always fallback
        end),
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            if max_width ~= 0 and #vim_item.abbr > max_width then
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end

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
                vim_item.kind = icons.misc.Smiley .. "  Emoji"
                vim_item.kind_hl_group = "CmpItemKindEmoji"
            end

            vim_item.menu = source_names[entry.source.name]
            vim_item.dup = duplicates[entry.source.name] or duplicates_default

            return vim_item
        end,
    },
    sources = {
        {
            name = "copilot",
            -- keyword_length = 0,
            max_item_count = 3,
            trigger_characters = {
                {
                    ".",
                    ":",
                    "(",
                    "'",
                    '"',
                    "[",
                    ",",
                    "#",
                    "*",
                    "@",
                    "|",
                    "=",
                    "-",
                    "{",
                    "/",
                    "\\",
                    "+",
                    "?",
                    " ",
                    -- "\t",
                    -- "\n",
                },
            },
        },
        {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
                local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                    return false
                end
                if kind == "Text" then
                    return false
                end
                return true
            end,
        },
        { name = "path" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "emoji" },
        { name = "crates" },
        { name = "npm" },
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
