return {
    -- Plugin configuration
    tools = { hover_actions = { replace_builtin_hover = false } },

    -- LSP configuration
    server = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    },

    -- DAP configuration
    dap = {},
}
