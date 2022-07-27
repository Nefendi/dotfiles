local status_ok, _ = pcall(require, "gitblame")
if not status_ok then
    return
end

local icons = require "user.icons"

vim.g.gitblame_enabled = 0
vim.g.gitblame_message_template = "<sha> "
    .. icons.misc.VerySmallDot
    .. " <summary> "
    .. icons.misc.VerySmallDot
    .. " <date> "
    .. icons.misc.VerySmallDot
    .. " <author>"
vim.g.gitblame_highlight_group = "LineNr"
