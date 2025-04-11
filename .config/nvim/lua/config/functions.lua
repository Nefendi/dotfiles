local M = {}

function M.toggle_option(option)
    local value = not vim.api.nvim_get_option_value(option, {})
    vim.opt[option] = value
    vim.notify(string.upper(option) .. " set to " .. tostring(value))
end

function M.list_registered_null_ls_providers(file_type, kind)
    local null_ls_sources = require "null-ls.sources"

    local available_sources = null_ls_sources.get_available(file_type)

    local registered = {}
    for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
            registered[method] = registered[method] or {}
            table.insert(registered[method], source.name)
        end
    end
    return registered[kind] or {}
end

function M.contains(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

function M.smart_quit()
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })

    if modified then
        vim.ui.select({ "Yes", "No" }, {
            prompt = "You have unsaved changes. Quit anyway?",
        }, function(choice)
            if choice == "Yes" then
                vim.cmd "q!"
            end
        end)
    else
        vim.cmd "q"
    end
end

-- Stolen from https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/util/ui.lua
function M.foldexpr()
    local buf = vim.api.nvim_get_current_buf()
    if vim.b[buf].ts_folds == nil then
        -- as long as we don't have a filetype, don't bother
        -- checking if treesitter is available (it won't)
        if vim.bo[buf].filetype == "" then
            return "0"
        end
        if vim.bo[buf].filetype:find "dashboard" then
            vim.b[buf].ts_folds = false
        else
            vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
        end
    end
    return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

return M
