return {
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        config = function()
            local surround = require "nvim-surround"

            surround.setup {
                invalid_key_behavior = function()
                    vim.notify("Invalid surround character", vim.log.levels.INFO)
                end,
            }
        end,
    },
}
