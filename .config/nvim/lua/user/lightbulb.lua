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
        text = icons.ui.GlowingLightbulb,
        win_opts = { anchor = "SW", offset_y = 1 },
    },
    virtual_text = { enabled = false, text = icons.ui.GlowingLightbulb, hl_mode = "replace" },
}

vim.fn.sign_define(
    "LightBulbSign",
    { text = icons.ui.GlowingLightbulb, texthl = "CmpItemKindEmoji", linehl = "", numhl = "" }
)

vim.api.nvim_set_hl(0, "LightBulbFloatWin", { fg = "#fde030" })
vim.api.nvim_set_hl(0, "LightBulbVirtualText", { fg = "#fde030", bg = "#292e42" })
