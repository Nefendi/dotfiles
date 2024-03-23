return {
    -- Plugin configuration
    tools = {},

    -- LSP configuration
    server = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    },

    -- DAP configuration
    dap = {},
}
