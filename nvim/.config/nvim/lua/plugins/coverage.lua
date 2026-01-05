return {
    {
        "andythigpen/nvim-coverage",
        version = "*",
        config = function()
            local coverage = require "coverage"

            coverage.setup()
        end,
    },
}
