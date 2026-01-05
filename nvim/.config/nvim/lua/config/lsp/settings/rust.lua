return {
    -- Plugin configuration
    tools = { hover_actions = { replace_builtin_hover = false } },

    -- LSP configuration
    server = {
        on_attach = require("config.lsp.handlers").on_attach,
        capabilities = require("config.lsp.handlers").capabilities,
    },

    -- DAP configuration
    dap = {},
}
