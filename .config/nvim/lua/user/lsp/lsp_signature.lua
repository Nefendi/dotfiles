local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
    return
end

local icons = require "user.icons"

lsp_signature.setup {
    floating_window = false,
    floating_window_above_cur_line = false,
    hint_prefix = icons.misc.Ghost .. " ",
    hint_scheme = "Comment",
    doc_lines = 0,
    max_width = 120,
}
