return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require "gitsigns"

            local icons = require "config.icons"

            gitsigns.setup {
                signs = {
                    add = { text = icons.misc.Bar },
                    change = {
                        text = icons.misc.Bar,
                    },
                    delete = {
                        text = icons.misc.RightTriangleArrow,
                    },
                    topdelete = {
                        text = icons.misc.RightTriangleArrow,
                    },
                    changedelete = {
                        text = icons.misc.Bar,
                    },
                },
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 0,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = "<abbrev_sha> "
                    .. icons.misc.VerySmallDot
                    .. " <author> "
                    .. icons.misc.VerySmallDot
                    .. " <author_time:%Y-%m-%d> "
                    .. icons.misc.VerySmallDot
                    .. " <summary>",
                word_diff = false,
            }
        end,
    },
}
