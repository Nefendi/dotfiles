local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
    return
end

local icons = require "user.icons"

-- vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "#2E3440", fg = "#E8AB53" })
-- vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = "#2E3440", fg = "#B180D7" })
-- vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "#2E3440", fg = "#75BEFF" })
-- vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "#2E3440", fg = "#75BEFF" })
-- vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "#2E3440", fg = "#E8AB53" })
-- vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "#2E3440", fg = "#E8AB53" })
-- vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "#2E3440", fg = "#B180D7" })
-- vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "#2E3440", fg = "#75BEFF" })
-- vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "#2E3440", fg = "#75BEFF" })
-- vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "#2E3440", fg = "#75BEFF" })
-- vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "#2E3440", fg = "#B180D7" })
-- vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "#2E3440", fg = "#abb2bf" })
-- vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "#2E3440", fg = "#6b737f" })
-- vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "#2E3440", fg = "#6b737f" })

navic.setup {
    icons = {
        File = icons.kind.File .. " %*",
        Module = icons.kind.Module .. " %*",
        Namespace = icons.kind.Namespace .. " %*",
        Package = icons.kind.Package .. " %*",
        Class = icons.kind.Class .. " %*",
        Method = icons.kind.Method .. " %*",
        Property = icons.kind.Property .. " %*",
        Field = icons.kind.Field .. " %*",
        Constructor = icons.kind.Constructor .. " %*",
        Enum = icons.kind.Enum .. " %*",
        Interface = icons.kind.Interface .. " %*",
        Function = icons.kind.Function .. " %*",
        Variable = icons.kind.Variable .. " %*",
        Constant = icons.kind.Constant .. " %*",
        String = icons.kind.String .. " %*",
        Number = icons.kind.Number .. " %*",
        Boolean = icons.kind.Boolean .. " %*",
        Array = icons.kind.Array .. " %*",
        Object = icons.kind.Object .. " %*",
        Key = icons.kind.Key .. " %*",
        Null = icons.kind.Null .. " %*",
        EnumMember = icons.kind.EnumMember .. " %*",
        Struct = icons.kind.Struct .. " %*",
        Event = icons.kind.Event .. " %*",
        Operator = icons.kind.Operator .. " %*",
        TypeParameter = icons.kind.TypeParameter .. " %*",
    },

    separator = " " .. icons.ui.NavicRightChevron .. " ",
    depth = 0,
    depth_limit_indicator = "..",
    highlight = true,
}
