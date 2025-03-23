return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local indent_blankline = require "ibl"

            local hooks = require "ibl.hooks"

            local highlights = {
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            }

            local indent_chars = { "╎", "╏", "┆", "┇", "┊", "┋" }

            indent_blankline.setup {
                scope = {
                    char = indent_chars,
                    highlight = highlights,
                    show_start = false,
                    show_end = false,
                },
                indent = {
                    char = indent_chars,
                },
                exclude = {
                    filetypes = {
                        "help",
                        "startify",
                        "dashboard",
                        "packer",
                        "neogitstatus",
                        "NvimTree",
                        "Trouble",
                        "text",
                    },
                    buftypes = { "terminal", "nofile" },
                },
            }

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
}
