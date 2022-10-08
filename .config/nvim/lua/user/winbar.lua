local icons = require "user.icons"

local functions = require "user.functions"

local M = {}

M.winbar_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "Jaq",
    "glowpreview",
    "dap-repl",
    "dap-terminal",
    "dapui_console",
    "lab",
    "",
}

local get_filename = function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"

    if not functions.isempty(filename) then
        local file_icon, file_icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

        local hl_group = "FileIconColor" .. extension

        vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })

        if functions.isempty(file_icon) then
            file_icon = icons.kind.File
        end

        local buf_ft = vim.bo.filetype

        local prefix = " "

        if buf_ft == "dapui_breakpoints" then
            file_icon = icons.misc.Bug
            prefix = ""
        end

        if buf_ft == "dapui_stacks" then
            file_icon = icons.ui.Stacks
            prefix = ""
        end

        if buf_ft == "dapui_scopes" then
            file_icon = icons.ui.Scopes
            prefix = ""
        end

        if buf_ft == "dapui_watches" then
            file_icon = icons.ui.Watches
            prefix = ""
        end

        local navic_text = vim.api.nvim_get_hl_by_name("NavicText", true)
        vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

        return prefix .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
    end
end

local get_navic = function()
    local status_navic_ok, navic = pcall(require, "nvim-navic")
    if not status_navic_ok then
        return ""
    end

    local status_ok, navic_location = pcall(navic.get_location, {})
    if not status_ok then
        return ""
    end

    if not navic.is_available() or navic_location == "error" then
        return ""
    end

    if not functions.isempty(navic_location) then
        return " " .. navic_location
    else
        return ""
    end
end

local excludes = function()
    if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return true
    end
    return false
end

M.get_winbar = function()
    if excludes() then
        return
    end

    local value = get_filename()

    if not functions.isempty(value) then
        local navic_value = get_navic()

        if functions.get_buf_option "mod" then
            value = value .. "%#LspCodeLens#" .. " " .. icons.misc.SmallDot .. "%*"
        end

        value = value .. " " .. navic_value
    end

    local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
    if not status_ok then
        return
    end
end

M.create_winbar = function()
    vim.api.nvim_create_augroup("_winbar", {})
    if vim.fn.has "nvim-0.8" == 1 then
        vim.api.nvim_create_autocmd(
            { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
            {
                group = "_winbar",
                callback = function()
                    local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
                    if not status_ok then
                        require("user.winbar").get_winbar()
                    end
                end,
            }
        )
    end
end

M.create_winbar()

return M
