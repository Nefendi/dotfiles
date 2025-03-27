local M = {}

function M.isempty(s)
    return s == nil or s == ""
end

function M.get_buf_option(opt)
    local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end

function M.toggle_option(option)
    local value = not vim.api.nvim_get_option_value(option, {})
    vim.opt[option] = value
    vim.notify(string.upper(option) .. " set to " .. tostring(value))
end

function M.list_registered_null_ls_providers(file_type, kind)
    local null_ls_sources__status_ok, null_ls_sources = pcall(require, "null-ls.sources")
    if not null_ls_sources__status_ok then
        return
    end

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
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
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

function M.get_hl_by_name(name)
    local ret = vim.api.nvim_get_hl_by_name(name.group, true)
    return string.format("#%06x", ret[name.property])
end

return M
