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
}
