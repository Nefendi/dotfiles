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
            },
            quickfix = {
                open = false,
            },
        },
        config = function(_, opts)
            local neotest = require "neotest"

            local neotest_python = require "neotest-python"

            local neotest_go = require "neotest-go"

            local neotest_jest = require "neotest-jest"

            local neotest_vitest = require "neotest-vitest"

            local neotest_elixir = require "neotest-elixir"

            local neotest_zig = require "neotest-zig"

            opts.adapters = {
                require "rustaceanvim.neotest",
                neotest_python,
                neotest_go,
                neotest_jest,
                neotest_vitest,
                neotest_elixir,
                neotest_zig,
            }

            neotest.setup(opts)
        end,
    },
}
