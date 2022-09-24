local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
    return
end

local icons = require "user.icons"

local error_red = "error"
local warning_orange = "warning"
local hint_blue = "hint"
local perf_purple = "#7C3AED"
local note_yellow = "#e0af68"

todo_comments.setup {
    keywords = {
        FIX = {
            icon = icons.misc.BugCodicon, -- icon used for the sign, and in search results
            color = error_red, -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = icons.ui.CheckCodicon .. " ", color = hint_blue, alt = { "TIP" } },
        HACK = { icon = icons.ui.FireCodicon .. " ", color = warning_orange },
        WARN = { icon = icons.diagnostics_codicons.Warning .. " ", color = warning_orange, alt = { "WARNING", "XXX" } },
        PERF = {
            icon = icons.ui.DashboardCodicon .. " ",
            color = perf_purple,
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "TEST" },
        },
        NOTE = { icon = icons.ui.NoteCodicon .. " ", color = note_yellow, alt = { "INFO" } },
    },
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
        keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        exclude = { "markdown" },
    },
}
