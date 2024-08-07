M = {}

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

M.server_capabilities = function()
    local active_clients = vim.lsp.get_clients()
    local active_client_map = {}

    for index, value in ipairs(active_clients) do
        active_client_map[value.name] = index
    end

    vim.ui.select(vim.tbl_keys(active_client_map), {
        prompt = "Select client:",
        format_item = function(item)
            return "capabilites for: " .. item
        end,
    }, function(choice)
        vim.print(vim.lsp.get_clients()[active_client_map[choice]].server_capabilities)
    end)
end

require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
require("lsp_lines").setup()

return M
