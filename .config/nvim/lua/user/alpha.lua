local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local dashboard = require "alpha.themes.dashboard"

local icons = require "user.icons"

local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    return b
end

dashboard.section.header.opts.hl = "AlphaHeader"

dashboard.section.header.val = {
    [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}

dashboard.section.buttons.val = {
    button("f", icons.documents.Files .. "  Find file", ":Telescope find_files <CR>"),
    button("e", icons.documents.File .. "  New file", ":ene <BAR> startinsert <CR>"),
    button("p", icons.git.Repo .. "  Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
    button("r", icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>"),
    button("t", icons.ui.List .. "  Find text", ":Telescope live_grep <CR>"),
    button("c", icons.ui.Cog .. "  Config", ":e ~/.config/nvim/init.lua <CR>"),
    button("q", icons.ui.Leave .. "  Quit", ":qa<CR>"),
}

dashboard.section.footer.val = {
    "",
    "",
    "I swear, by my life and my love of it,",
    "that I will never live for the sake of another man,",
    "nor ask another man to live for mine.",
    "",
    "                                       -- John Galt",
}

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
