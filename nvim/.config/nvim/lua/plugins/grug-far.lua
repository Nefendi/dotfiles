local ripgrep_flags = "--hidden --no-ignore"

return {
    {
        "MagicDuck/grug-far.nvim",
        opts = {
            headerMaxWidth = 80,
            enabledEngines = { "ripgrep" },
            -- Would be nice to have extra args prefilled
            -- engines = {
            --     ripgrep = {
            --         extraArgs = "--hidden --no-ignore",
            --     },
            -- },
        },
        cmd = "GrugFar",
        keys = {
            { "<leader>r", desc = "Replace", mode = { "n", "v" } },
            {
                "<leader>rf",
                function()
                    local grug = require "grug-far"
                    grug.open {
                        transient = true,
                        prefills = {
                            paths = vim.fn.expand "%",
                        },
                    }
                end,
                mode = { "n", "v" },
                desc = "Replace in the Current File",
            },
            {
                "<leader>rw",
                function()
                    local grug = require "grug-far"
                    grug.open {
                        transient = true,
                        prefills = {
                            search = vim.fn.expand "<cword>",
                            flags = ripgrep_flags,
                        },
                    }
                end,
                mode = { "n" },
                desc = "Replace Word",
            },
            {
                "<leader>rr",
                function()
                    local grug = require "grug-far"
                    local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
                    grug.open {
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                            flags = ripgrep_flags,
                        },
                    }
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },
}
