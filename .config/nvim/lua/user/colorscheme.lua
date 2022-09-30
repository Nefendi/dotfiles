local colorscheme = "tokyonight"

-- vim.g.onedarker_italic_keywords = true
-- vim.g.onedarker_italic_functions = false
-- vim.g.onedarker_italic_comments = true
-- vim.g.onedarker_italic_loops = true
-- vim.g.onedarker_italic_conditionals = true

-- vim.g.darkplus_italic_keywords = true
-- vim.g.darkplus_italic_functions = false
-- vim.g.darkplus_italic_comments = true
-- vim.g.darkplus_italic_loops = true
-- vim.g.darkplus_italic_conditionals = true

local tokyonight_status_ok, tokyonight = pcall(require, "tokyonight")

if not tokyonight_status_ok then
    return
end

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
        hl.TSConstructor = {
            fg = c.blue1,
        }
        hl.TSTagDelimiter = {
            fg = c.dark5,
        }
        hl.WinSeparator = {
            fg = c.dark5,
        }
    end,
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    return
end
