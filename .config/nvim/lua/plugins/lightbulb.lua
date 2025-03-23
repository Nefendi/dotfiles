return {
    {
        "kosayoda/nvim-lightbulb",
        event = "BufReadPost",
        dependencies = "antoinemadec/FixCursorHold.nvim",
        config = function()
            local lightbulb = require "nvim-lightbulb"

            local icons = require "config.icons"

            lightbulb.setup {
                sign = { enabled = true, text = icons.diagnostics.Hint },
                number = { enabled = false, text = icons.diagnostics.Hint },
                autocmd = { enabled = true },
                float = {
                    enabled = false,
                    text = icons.diagnostics.Hint,
                },
                virtual_text = { enabled = false, text = icons.diagnostics.Hint, hl_mode = "replace" },
            }

            vim.api.nvim_set_hl(0, "LightBulbFloatWin", { fg = "#fde030", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "LightBulbVirtualText", { fg = "#fde030", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "LightBulbSign", { fg = "#fde030", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "LightBulbNumber", { fg = "#fde030", bg = "#1a1b26" })
        end,
    },
}
