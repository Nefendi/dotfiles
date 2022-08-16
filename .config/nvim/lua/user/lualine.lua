local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- local lualine_scheme = "darkplus_dark"
local lualine_scheme = "onedarker_alt"

local status_theme_ok, theme = pcall(require, "lualine.themes." .. lualine_scheme)
if not status_theme_ok then
    return
end

local icons = require "user.icons"

local functions = require "user.functions"

local hide_in_width_60 = function()
    return vim.o.columns > 60
end

local hide_in_width = function()
    return vim.o.columns > 80
end

local hide_in_width_100 = function()
    return vim.o.columns > 100
end

local gray = "#32363e"
local dark_gray = "#282C34"
local red = "#D16969"
local blue = "#569CD6"
local green = "#6A9955"
local cyan = "#4EC9B0"
local orange = "#CE9178"
local indent = "#CE9178"
local yellow = "#DCDCAA"
local yellow_orange = "#D7BA7D"
local purple = "#C586C0"

if lualine_scheme == "darkplus_dark" then
    gray = "#303030"
    dark_gray = "#303030"
    red = "#bf616a"
    blue = "#5e81ac"
    green = "#A3BE8C"
    cyan = "#88c0d0"
    orange = "#C68A75"
    yellow = "#DCDCAA"
    yellow_orange = "#D7BA7D"
    purple = "#B48EAD"
end

local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
-- local sl_hl_sep = vim.api.nvim_get_hl_by_name("StatusLineSeparator", true)

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = dark_gray })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = purple, bg = gray })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = dark_gray, bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = purple, bg = gray })
vim.api.nvim_set_hl(0, "SLLocation", { fg = blue, bg = gray })
vim.api.nvim_set_hl(0, "SLFT", { fg = cyan, bg = gray })
vim.api.nvim_set_hl(0, "SLIndent", { fg = indent, bg = gray })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#6b727f", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSep", { fg = gray, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = "NONE", italic = true })
vim.api.nvim_set_hl(0, "SLError", { fg = "#bf616a", bg = sl_hl.background })
vim.api.nvim_set_hl(0, "SLWarning", { fg = "#D7BA7D", bg = sl_hl.background })
vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = sl_hl.background })
vim.api.nvim_set_hl(0, "SLError", { fg = red, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLWarning", { fg = orange, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLInfo", { fg = yellow, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLHint", { fg = blue, bg = "NONE" })

local hl_str = function(str, hl)
    return "%#" .. hl .. "#" .. str .. "%*"
end

local left_pad = {
    function()
        return ""
    end,
    padding = 0,
    color = function()
        return { fg = gray }
    end,
}

local right_pad = {
    function()
        return " "
    end,
    padding = 0,
    color = function()
        return { fg = dark_gray }
    end,
}

local left_pad_alt = {
    function()
        return "  "
    end,
    padding = 0,
    color = function()
        return { fg = gray }
    end,
}

local right_pad_alt = {
    function()
        return "  "
    end,
    padding = 0,
    color = function()
        return { fg = gray }
    end,
}

local mode_color = {
    n = blue,
    i = orange,
    v = "#b668cd",
    [""] = "#b668cd",
    V = "#b668cd",
    c = "#46a6b2",
    no = "#D16D9E",
    s = green,
    S = orange,
    [""] = orange,
    ic = red,
    R = "#D16D9E",
    Rv = red,
    cv = blue,
    ce = blue,
    r = red,
    rm = "#46a6b2",
    ["r?"] = "#46a6b2",
    ["!"] = "#46a6b2",
    t = red,
}

local mode = {
    function()
        return " "
    end,
    color = function()
        return { fg = mode_color[vim.fn.mode()], bg = gray }
    end,
    padding = 0,
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = {
        error = "%#SLError#" .. icons.diagnostics_codicons.Error .. "%*" .. " ",
        warn = "%#SLWarning#" .. icons.diagnostics_codicons.Warning .. "%*" .. " ",
        info = "%#SLInfo#" .. icons.diagnostics_codicons.Info .. "%*" .. " ",
        hint = "%#SLHint#" .. icons.diagnostics_codicons.Hint .. "%*" .. " ",
    },
    colored = false,
    update_in_insert = false,
    always_visible = true,
    padding = 0,
}

local diff = {
    "diff",
    symbols = {
        added = icons.git.Added .. " ",
        modified = icons.git.Modified .. " ",
        removed = icons.git.Removed .. " ",
    }, -- changes diff symbols
    diff_color = {
        added = { fg = green },
        modified = { fg = yellow },
        removed = { fg = red },
    },
    cond = hide_in_width_60,
    padding = 0,
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
        }

        local return_val = function(str)
            return hl_str("", "SLSep") .. hl_str(str, "SLFT") .. hl_str("", "SLSep")
        end

        if str == "TelescopePrompt" then
            return return_val(icons.ui.Telescope .. " ")
        end

        local function get_term_num()
            local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
            if not t_status_ok then
                return ""
            end
            return toggle_num
        end

        if str == "toggleterm" then
            local term = "%#SLTermIcon#" .. " " .. "%*" .. "%#SLFT#" .. get_term_num() .. "%*"

            return return_val(term)
        end

        if functions.contains(ui_filetypes, str) then
            return ""
        else
            return return_val(str)
        end
    end,
    icons_enabled = false,
    padding = 0,
}

local filename = {
    "filename",
    color = {},
    cond = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "%#SLGitIcon#" .. " " .. icons.git.Branch .. "%*" .. "%#SLBranchName#",
    colored = false,
    padding = 0,
    fmt = function(str)
        if str == "" or str == nil then
            return "NO VCS"
        end

        return str
    end,
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
        return hl_str(" ", "SLSep") .. hl_str(text .. size, "SLIndent") .. hl_str("", "SLSep")
    end,
    padding = 0,
}

local fileformat = {
    "fileformat",
    icons_enabled = false,
    fmt = function(str)
        return hl_str(" ", "SLSep") .. hl_str(string.upper(str), "SLIndent") .. hl_str(" ", "SLSep")
    end,
    padding = 0,
}

local encoding = {
    "o:encoding",
    fmt = function(str)
        return hl_str(" ", "SLSep") .. hl_str(string.upper(str), "SLIndent") .. hl_str("", "SLSep")
    end,
    cond = hide_in_width,
    padding = 0,
}

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local lsp = {
    function(_)
        local M = {}
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
            if M.language_servers == nil then
                return ""
            else
                return M.language_servers
            end
        end

        local buf_clients = vim.lsp.buf_get_clients()
        local buf_client_names = {}

        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        local supported_formatters = functions.list_registered_null_ls_providers(buf_ft, null_ls.methods.FORMATTING)
        vim.list_extend(buf_client_names, supported_formatters)

        local supported_linters = functions.list_registered_null_ls_providers(buf_ft, null_ls.methods.DIAGNOSTICS)
        vim.list_extend(buf_client_names, supported_linters)

        buf_client_names = table.concat(buf_client_names, ", ")

        local language_servers = ""
        local client_names_str_len = #buf_client_names

        if client_names_str_len ~= 0 then
            language_servers = hl_str(" ", "SLSep")
                .. hl_str(buf_client_names, "SLSeparator")
                .. hl_str(" ", "SLSep")
        end

        if client_names_str_len == 0 then
            return ""
        else
            M.language_servers = language_servers
            return language_servers:gsub(", anonymous source", "")
        end
    end,
    padding = 0,
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
    color = { fg = green },
    cond = hide_in_width_60,
}

local current_signature = {
    function()
        local buf_ft = vim.bo.filetype

        if buf_ft == "toggleterm" or buf_ft == "TelescopePrompt" then
            return ""
        end

        if not pcall(require, "lsp_signature") then
            return ""
        end

        local sig = require("lsp_signature").status_line(30)
        local hint = sig.hint

        if not functions.isempty(hint) then
            return "%#SLSeparator# " .. hint .. "%*"
        end

        return ""
    end,
    cond = hide_in_width_100,
    padding = 0,
}

local treesitter = {
    function()
        local b = vim.api.nvim_get_current_buf()
        if next(vim.treesitter.highlighter.active[b]) then
            return icons.misc.Tree
        end
        return ""
    end,
    color = { fg = green },
    cond = hide_in_width,
}

local location = {
    "location",
    fmt = function(str)
        return hl_str(" ", "SLSep") .. hl_str(str, "SLLocation") .. hl_str(" ", "SLSep")
    end,
    padding = 0,
    -- color = function()
    -- 	-- darkplus
    -- 	-- return { fg = "#252525", bg = mode_color[vim.fn.mode()] }
    -- 	-- onedarker
    -- 	return { fg = "#1E232A", bg = mode_color[vim.fn.mode()] }
    -- end,
}

local progress = {
    "progress",
    fmt = function(_)
        return hl_str("", "SLSep") .. hl_str("%P/%L", "SLProgress") .. hl_str("", "SLSep")
    end,
    padding = 0,
}

lualine.setup {
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { left_pad, mode, branch, right_pad },
        lualine_b = { left_pad_alt, diagnostics, right_pad_alt },
        lualine_c = { python_env, current_signature },
        -- lualine_x = { diff, spaces, encoding, fileformat, filetype },
        lualine_x = { lsp, spaces, encoding, fileformat, filetype },
        lualine_y = { location },
        lualine_z = { progress },
    },
}
