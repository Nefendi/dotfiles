return {
    {
        "SmiteshP/nvim-navic",
        event = "VeryLazy",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            local navic = require "nvim-navic"

            local icons = require "config.icons"

            navic.setup {
                lsp = {
                    auto_attach = false,
                },
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
        end,
    },
}
