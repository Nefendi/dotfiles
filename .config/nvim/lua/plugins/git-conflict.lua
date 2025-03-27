return {
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            local git_conflict = require "git-conflict"

            vim.api.nvim_set_hl(0, "GitConflictIncomingBg", { bg = "#344f69" })
            vim.api.nvim_set_hl(0, "GitConflictCurrentBg", { bg = "#2e5049" })
            vim.api.nvim_set_hl(0, "GitConflictAncestorBg", { bg = "#5e3b67" })

            git_conflict.setup {
                default_mappings = true, -- disable buffer local mapping created by this plugin
                disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = "GitConflictIncomingBg",
                    current = "GitConflictCurrentBg",
                    ancestor = "GitConflictAncestorBg",
                },
            }
        end,
    },
}
