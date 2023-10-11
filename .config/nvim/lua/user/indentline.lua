local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
    return
end

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
