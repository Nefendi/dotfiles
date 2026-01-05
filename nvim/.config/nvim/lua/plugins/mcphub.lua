return {
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
        opts = {
            ui = {
                window = {
                    border = "rounded",
                },
            },
        },
        keys = {
            {
                "<leader>am",
                "<CMD>MCPHub<CR>",
                desc = "MCPHub",
            },
        },
    },
}
