return {
    {
        "ellisonleao/glow.nvim",
        ft = "markdown",
        config = function()
            local glow = require "glow"

            glow.setup {
                border = "rounded",
                width = 200,
            }
        end,
    },
}
