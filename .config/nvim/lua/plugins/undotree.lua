return {
    {
        "jiaoshijie/undotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local undotree = require "undotree"

            undotree.setup {
                float_diff = true, -- using float window previews diff, set this `true` will disable layout option
                layout = "left_bottom", -- "left_bottom", "left_left_bottom"
                ignore_filetype = {
                    "Undotree",
                    "UndotreeDiff",
                    "qf",
                    "TelescopePrompt",
                    "tsplayground",
                },
                window = {
                    winblend = 0,
                },
                keymaps = {
                    ["j"] = "move_next",
                    ["k"] = "move_prev",
                    ["J"] = "move_change_next",
                    ["K"] = "move_change_prev",
                    ["<cr>"] = "action_enter",
                    ["p"] = "enter_diffbuf",
                    ["q"] = "quit",
                },
            }
        end,
    },
}
