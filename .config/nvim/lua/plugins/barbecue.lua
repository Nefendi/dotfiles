return {
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local barbecue = require "barbecue"

            barbecue.setup {
                attach_navic = false,
                show_modified = true,
                exclude_filetypes = {
                    "help",
                    "startify",
                    "dashboard",
                    "packer",
                    "neogitstatus",
                    "NvimTree",
                    "oil",
                    "Trouble",
                    "alpha",
                    "lir",
                    "Outline",
                    "toggleterm",
                    "gitcommit",
                    "gitrebase",
                    "Jaq",
                    "glowpreview",
                    "dap-repl",
                    "dap-terminal",
                    "dapui_console",
                    "lab",
                    "cabal",
                    "bzl",
                    "gomod",
                    "gosum",
                    "gowork",
                    "asciidoc",
                    "",
                },
            }
        end,
    },
}
