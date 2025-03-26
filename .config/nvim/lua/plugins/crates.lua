return {
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        tag = "stable",
        config = function()
            local crates = require "crates"

            crates.setup {
                popup = {
                    border = "rounded",
                },
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                completion = {
                    crates = { enabled = true },
                    cmp = { enabled = true },
                },
            }
        end,
    },
}
