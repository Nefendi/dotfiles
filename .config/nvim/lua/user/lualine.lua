local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local lualine_scheme = require("user.colorscheme").colorscheme

local status_theme_ok, theme = pcall(require, "lualine.themes." .. lualine_scheme)
if not status_theme_ok then
    return
end

local icons = require "user.icons"
local functions = require "user.functions"

local function extract_fg_color(name)
    return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
    end
end

local hl_str = function(str, hl)
    return "%#" .. hl .. "#" .. str .. "%*"
end

local hide_in_width_60 = function()
    return vim.o.columns > 60
end

local hide_in_width = function()
    return vim.o.columns > 80
end

local hide_in_width_200 = function()
    return vim.o.columns > 200
end

local colors = {
    gray = "#24284b",
    dark_gray = "#292e42",
    light_gray = "#6b727f",
    red = "#db4b4b",
    blue = "#7aa2f7",
    green = "#9ece6a",
    yellow = "#e0af68",
    orange = "#ff9e64",
    bg = theme.normal.c.bg,
    teal = "#1abc9c",
    fg = "#abb2bf",
    cyan = "#46a6b2",
    light_orange = "#e8ab53",
    magenta = "#b668cd",
    pink = "#d16d9e",
    light_green = "#6cc644",
}

vim.api.nvim_set_hl(0, "SLFG", { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = colors.light_gray, bg = colors.bg })

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = colors.light_orange, bg = colors.dark_gray })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = colors.fg, bg = colors.dark_gray, bold = false })
vim.api.nvim_set_hl(0, "SLYellow", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "SLCopilot", { fg = colors.light_green, bg = colors.bg })

vim.api.nvim_set_hl(0, "SLError", { fg = colors.red, bg = colors.bg })
vim.api.nvim_set_hl(0, "SLWarning", { fg = colors.yellow, bg = colors.bg })
vim.api.nvim_set_hl(0, "SLInfo", { fg = colors.blue, bg = colors.bg })
vim.api.nvim_set_hl(0, "SLHint", { fg = colors.teal, bg = colors.bg })

vim.api.nvim_set_hl(0, "SLDiffAdd", { fg = colors.green, bg = colors.bg })
vim.api.nvim_set_hl(0, "SLDiffChange", { fg = colors.yellow, bg = colors.bg })
vim.api.nvim_set_hl(0, "SLDiffDelete", { fg = colors.red, bg = colors.bg })

vim.api.nvim_set_hl(0, "SLPluginUpdates", { fg = colors.orange, bg = colors.bg })

local mode_color = {
    n = colors.blue,
    i = colors.orange,
    v = colors.magenta,
    [""] = colors.magenta,
    V = colors.magenta,
    c = colors.cyan,
    no = colors.pink,
    s = colors.green,
    S = colors.orange,
    [""] = colors.orange,
    ic = colors.red,
    R = colors.pink,
    Rv = colors.red,
    cv = colors.blue,
    ce = colors.blue,
    r = colors.red,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.cyan,
    t = colors.red,
}

local mode = {
    function()
        return "▊"
    end,
    color = function()
        return { fg = mode_color[vim.fn.mode()], bg = colors.dark_gray }
    end,
    padding = 0,
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = {
        error = "%#SLError#" .. icons.diagnostics.Error .. "%*" .. "%#SLFG# ",
        warn = "%#SLWarning#" .. icons.diagnostics.Warning .. "%*" .. "%#SLFG# ",
        info = "%#SLInfo#" .. icons.diagnostics.Info .. "%*" .. "%#SLFG# ",
        hint = "%#SLHint#" .. icons.diagnostics.Hint .. "%*" .. "%#SLFG# ",
    },
    update_in_insert = false,
    always_visible = true,
    padding = 1,
}

local diff = {
    "diff",
    symbols = {
        added = hl_str(icons.git.Added .. " ", "SLDiffAdd"),
        modified = hl_str(icons.git.Modified .. " ", "SLDiffChange"),
        removed = hl_str(icons.git.Removed .. " ", "SLDiffDelete"),
    },
    cond = hide_in_width_200,
    padding = { left = 2, right = 1 },
}

local filetype = {
    "filetype",
    fmt = function(str)
        local ui_filetypes = {
            "help",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "",
            "nil",
            "neotest-summary",
            "neotest-attach",
        }

        if str == "TelescopePrompt" then
            return icons.ui.Telescope
        end

        local function get_term_num()
            local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
            if not t_status_ok then
                return ""
            end
            return toggle_num
        end

        if str == "toggleterm" then
            local term = " " .. "%#SLFG#" .. get_term_num() .. "%*"

            return term
        end

        if functions.contains(ui_filetypes, str) then
            return ""
        else
            return str
        end
    end,
    icons_enabled = false,
    padding = 1,
    color = extract_fg_color "SLInfo",
    cond = hide_in_width_200,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "%#SLGitIcon#" .. " " .. icons.git.Branch .. "%*" .. "%#SLBranchName#",
    colored = false,
    padding = { right = 1 },
}

local spaces = {
    function()
        local text = "spaces: "
        local size = vim.api.nvim_buf_get_option(0, "shiftwidth")

        if not vim.api.nvim_buf_get_option(0, "expandtab") then
            text = "tab size: "
            size = vim.api.nvim_buf_get_option(0, "tabstop")

            goto continue
        end

        if size == 0 then
            size = vim.api.nvim_buf_get_option(0, "tabstop")
        end

        ::continue::
        return text .. size
    end,
    padding = 1,
    color = extract_fg_color "SLYellow",
}

local fileformat = {
    "fileformat",
    icons_enabled = false,
    fmt = function(str)
        return string.upper(str)
    end,
    padding = 1,
    color = extract_fg_color "SLYellow",
}

local encoding = {
    "o:encoding",
    fmt = function(str)
        return string.upper(str)
    end,
    cond = hide_in_width,
    padding = 1,
    color = extract_fg_color "SLYellow",
}

local lsp = {
    function(_)
        local buf_ft = vim.bo.filetype
        local ui_filetypes = {
            "help",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "TelescopePrompt",
            "lspinfo",
            "lsp-installer",
            "",
        }

        if functions.contains(ui_filetypes, buf_ft) then
            return ""
        end

        local buf_clients = vim.lsp.get_active_clients()
        local buf_client_names = {}

        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        local supported_formatters = functions.list_registered_null_ls_providers(buf_ft, null_ls.methods.FORMATTING)

        if supported_formatters then
            vim.list_extend(buf_client_names, supported_formatters)
        end

        local supported_linters = functions.list_registered_null_ls_providers(buf_ft, null_ls.methods.DIAGNOSTICS)

        if supported_linters then
            vim.list_extend(buf_client_names, supported_linters)
        end

        local clients = table.concat(buf_client_names, ", ")

        if #clients == 0 then
            return ""
        else
            return hl_str("[" .. clients .. "]", "SLFG"):gsub(", anonymous source", "")
        end
    end,
    padding = 1,
    cond = hide_in_width,
}

local function python_env_cleanup(venv)
    if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch "([^/]+)" do
            final_venv = w
        end
        venv = final_venv
    end
    return venv
end

local python_env = {
    function()
        if vim.bo.filetype == "python" then
            local venv = os.getenv "CONDA_DEFAULT_ENV"
            if venv then
                return string.format("%s (%s)", icons.misc.Python, python_env_cleanup(venv))
            end
            venv = os.getenv "VIRTUAL_ENV"
            if venv then
                return string.format("%s (%s)", icons.misc.Python, python_env_cleanup(venv))
            end
            return ""
        end
        return ""
    end,
    color = { fg = colors.green },
    cond = hide_in_width_60,
}

local location = {
    "location",
    color = function()
        return { fg = mode_color[vim.fn.mode()], bg = colors.gray }
    end,
    padding = 1,
    separator = { left = "", right = "" },
}

local progress = {
    "progress",
    fmt = function(_)
        return "%P/%L"
    end,
    color = function()
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 0, right = 1 },
    separator = { left = "", right = "" },
}

local plugin_updates = {
    -- Stolen from: https://github.com/folke/lazy.nvim/blob/57cce98dfdb2f2dd05a0567d89811e6d0505e13b/lua/lazy/status.lua#L5
    function()
        local checker = require "lazy.manage.checker"
        local updates = #checker.updated
        return updates > 0 and (hl_str(icons.kind.Package, "SLPluginUpdates") .. hl_str(updates, "SLFG"))
    end,
    cond = require("lazy.status").has_updates and hide_in_width_200,
}

local time = {
    function()
        return " " .. os.date "%R"
    end,
    color = function()
        return { bg = mode_color[vim.fn.mode()] }
    end,
    separator = { left = "", right = "" },
}

lualine.setup {
    options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        component_separators = hl_str("|", "SLSeparator"),
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = {
            diff,
            diagnostics,
            python_env,
        },
        lualine_x = {
            lsp,
            spaces,
            encoding,
            fileformat,
            filetype,
            plugin_updates,
        },
        lualine_y = {
            location,
            progress,
        },
        lualine_z = { time },
    },
}
