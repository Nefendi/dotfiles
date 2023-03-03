local status_ok, lightbulb = pcall(require, "nvim-lightbulb")
if not status_ok then
    return
end

local icons = require "user.icons"

lightbulb.setup {
    sign = { enabled = true },
    autocmd = { enabled = true },
    float = {
        enabled = false,
        text = icons.diagnostics.Hint,
        win_opts = { anchor = "SE", border = "none", style = "minimal" },
    },
    virtual_text = { enabled = false, text = icons.diagnostics.Hint, hl_mode = "replace" },
}

vim.fn.sign_define(
    "LightBulbSign",
    { text = icons.diagnostics.Hint, texthl = "CmpItemKindEmoji", linehl = "", numhl = "" }
)

vim.api.nvim_set_hl(0, "LightBulbFloatWin", { fg = "#fde030", bg = "#1a1b26" })
vim.api.nvim_set_hl(0, "LightBulbVirtualText", { fg = "#fde030", bg = "#1a1b26" })
