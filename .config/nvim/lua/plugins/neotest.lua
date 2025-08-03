return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-go",
            "haydenmeade/neotest-jest",
            "marilari88/neotest-vitest",
            "jfpedroza/neotest-elixir",
            "lawrence-laz/neotest-zig",
            "mrcjkb/rustaceanvim",
            -- FIXME: The config.lsp file needs to be run before rustaceanvim neotest can be configured here.
            -- Try to find a better way to do that in the future.
            "neovim/nvim-lspconfig",
        },
        ---@module "neotest"
        ---@type neotest.Config
        opts = {
            output_panel = {
                open = "botright split | resize 30",
            },
            floating = {
                max_height = 0.8,
                max_width = 0.8,
                border = "rounded",
            },
            quickfix = {
                open = false,
            },
        },
        config = function(_, opts)
            opts.adapters = {
                require "rustaceanvim.neotest",
                require "neotest-python",
                require "neotest-go",
                require "neotest-jest",
                require "neotest-vitest",
                require "neotest-elixir",
                require "neotest-zig",
            }

            require("neotest").setup(opts)
        end,
    },
}
