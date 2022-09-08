local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
    return
end

local icons = require "user.icons"

vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "#2E3440", fg = "#E8AB53" })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = "#2E3440", fg = "#B180D7" })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "#2E3440", fg = "#75BEFF" })
vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "#2E3440", fg = "#75BEFF" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "#2E3440", fg = "#E8AB53" })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "#2E3440", fg = "#E8AB53" })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "#2E3440", fg = "#B180D7" })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "#2E3440", fg = "#75BEFF" })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "#2E3440", fg = "#75BEFF" })
vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "#2E3440", fg = "#75BEFF" })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "#2E3440", fg = "#B180D7" })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "#2E3440", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "#2E3440", fg = "#6b737f" })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "#2E3440", fg = "#6b737f" })

navic.setup {
    icons = {
        File = icons.kind_codicons.File .. " %*",
        Module = icons.kind_codicons.Module .. " %*",
        Namespace = icons.kind_codicons.Namespace .. " %*",
        Package = icons.kind_codicons.Package .. " %*",
        Class = icons.kind_codicons.Class .. " %*",
        Method = icons.kind_codicons.Method .. " %*",
        Property = icons.kind_codicons.Property .. " %*",
        Field = icons.kind_codicons.Field .. " %*",
        Constructor = icons.kind_codicons.Constructor .. " %*",
        Enum = icons.kind_codicons.Enum .. " %*",
        Interface = icons.kind_codicons.Interface .. " %*",
        Function = icons.kind_codicons.Function .. " %*",
        Variable = icons.kind_codicons.Variable .. " %*",
        Constant = icons.kind_codicons.Constant .. " %*",
        String = icons.kind_codicons.String .. " %*",
        Number = icons.kind_codicons.Number .. " %*",
        Boolean = icons.kind_codicons.Boolean .. " %*",
        Array = icons.kind_codicons.Array .. " %*",
        Object = icons.kind_codicons.Object .. " %*",
        Key = icons.kind_codicons.Key .. " %*",
        Null = icons.kind_codicons.Null .. " %*",
        EnumMember = icons.kind_codicons.EnumMember .. " %*",
        Struct = icons.kind_codicons.Struct .. " %*",
        Event = icons.kind_codicons.Event .. " %*",
        Operator = icons.kind_codicons.Operator .. " %*",
        TypeParameter = icons.kind_codicons.TypeParameter .. " %*",
    },

    separator = " " .. icons.ui.NavicRightChevron .. " ",
    depth = 0,
    depth_limit_indicator = "..",
    highlight = true,
}
