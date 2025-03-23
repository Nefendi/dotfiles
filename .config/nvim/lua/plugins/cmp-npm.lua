return {
    {
        "David-Kunz/cmp-npm",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufRead package.json",
        config = function()
            local cmp_npm = require "cmp-npm"

            cmp_npm.setup()
        end,
    },
}
