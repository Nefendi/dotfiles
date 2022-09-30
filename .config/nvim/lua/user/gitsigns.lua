local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

local icons = require "user.icons"

gitsigns.setup {
    signs = {
        add = { hl = "GitSignsAdd", text = icons.misc.Bar, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = {
            hl = "GitSignsChange",
            text = icons.misc.Bar,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
        delete = {
            hl = "GitSignsDelete",
            text = icons.misc.RightTriangleArrow,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = icons.misc.RightTriangleArrow,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        changedelete = {
            hl = "GitSignsChange",
            text = icons.misc.Bar,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
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
}
