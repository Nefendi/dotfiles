return {
    {
        "ggandor/leap.nvim",
        config = function()
            local leap = require "leap"

            vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })

            leap.set_default_mappings()
        end,
    },
}
