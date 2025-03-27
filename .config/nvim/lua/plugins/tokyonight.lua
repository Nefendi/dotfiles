return {
    {
        "folke/tokyonight.nvim",
        config = function()
            local tokyonight = require "tokyonight"

            tokyonight.setup {
                style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = false, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
                sidebars = {
                    "qf",
                    "vista_kind",
                    "terminal",
                    "packer",
                    "spectre_panel",
                    "NeogitStatus",
                    "help",
                }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
                hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
                dim_inactive = false, -- dims inactive windows
                lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
                use_background = true,
                on_highlights = function(hl, c)
                    hl.IndentBlanklineContextChar = {
                        fg = c.dark5,
                    }
                    hl.WinSeparator = {
                        fg = c.dark5,
                    }
                end,
            }
        end,
    },
}
