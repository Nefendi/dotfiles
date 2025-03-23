return {
    {
        "smjonas/inc-rename.nvim",
        event = "BufReadPost",
        config = function()
            local inc_rename = require "inc_rename"

            inc_rename.setup { cmd_name = "Rename" }
        end,
    },
}
