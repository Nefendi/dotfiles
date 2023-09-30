local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
    return
end

local hooks = require "ibl.hooks"

local icons = require "user.icons"

local highlights = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
}

vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "text",
}

vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = icons.misc.LeftThinBar
-- vim.g.indent_blankline_char_list = { "|", "¦", "┆", "┊" }
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_use_treesitter = false
vim.g.indent_blankline_show_current_context = true

-- vim.g.indent_blankline_context_patterns = {
--     "class",
--     "return",
--     "function",
--     "method",
--     "^if",
--     "^while",
--     "jsx_element",
--     "^for",
--     "^object",
--     "^table",
--     "block",
--     "arguments",
--     "if_statement",
--     "else_clause",
--     "jsx_element",
--     "jsx_self_closing_element",
--     "try_statement",
--     "catch_clause",
--     "import_statement",
--     "operation_type",
-- }

indent_blankline.setup {
    show_current_context = true,
    scope = { highlight = highlights },
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
