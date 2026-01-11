-- Taken from https://www.lazyvim.org/plugins/treesitter

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        version = false,
        build = ":TSUpdate",
        event = "VeryLazy",
        cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
        dependencies = {
            { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            {
                "nvim-treesitter/nvim-treesitter-context",
                event = "BufReadPost",
                opts = {},
            },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "RRethy/nvim-treesitter-endwise", event = "BufReadPost" },
            "vrischmann/tree-sitter-templ",
        },
        opts = {
            ensure_installed = "all",
            highlight = { enable = true },
            indent = { enable = true },
            folds = { enable = true },
        },
        config = function(_, opts)
            local TS = require "nvim-treesitter"

            TS.setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
                callback = function(ev)
                    -- Hihglighting
                    pcall(vim.treesitter.start, ev.buf)

                    -- Indenting
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            require("nvim-dap-repl-highlights").setup()

            require("rainbow-delimiters.setup").setup {
                strategy = {
                    [""] = "rainbow-delimiters.strategy.global",
                    vim = "rainbow-delimiters.strategy.local",
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
                blacklist = { "html" },
            }
        end,
    },
}
