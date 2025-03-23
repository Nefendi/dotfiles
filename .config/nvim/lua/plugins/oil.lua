return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            local oil = require "oil"

            oil.setup {
                view_options = {
                    show_hidden = true,
                },
                use_default_keymaps = false,
                keymaps = {
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["<CR>"] = "actions.select",
                    ["L"] = "actions.select",
                    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<leader>p"] = "actions.preview",
                    ["<C-c>"] = { "actions.close", mode = "n" },
                    ["<leader>c"] = { "actions.close", mode = "n" },
                    ["<leader>e"] = { "actions.close", mode = "n" },
                    ["<C-l>"] = "actions.refresh",
                    ["<leader>r"] = "actions.refresh",
                    ["-"] = { "actions.parent", mode = "n" },
                    ["H"] = { "actions.parent", mode = "n" },
                    ["_"] = { "actions.open_cwd", mode = "n" },
                    ["`"] = { "actions.cd", mode = "n" },
                    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                    ["gs"] = { "actions.change_sort", mode = "n" },
                    ["gx"] = "actions.open_external",
                    ["g."] = { "actions.toggle_hidden", mode = "n" },
                    ["g\\"] = { "actions.toggle_trash", mode = "n" },
                },
            }
        end,
    },
}
