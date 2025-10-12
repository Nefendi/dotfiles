local function as_ft(key_specific_args)
    local common_args = {
        inputlen = 1,
        inclusive = true,
        opts = {
            labels = "",
            safe_labels = vim.fn.mode(1):match "[no]" and "" or nil,
            case_sensitive = true,
        },
    }
    return vim.tbl_deep_extend("keep", common_args, key_specific_args)
end

return {
    {
        "ggandor/leap.nvim",
        config = function()
            local leap = require "leap"

            vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })

            leap.set_default_mappings()

            local clever = require("leap.user").with_traversal_keys
            local clever_f = clever("f", "F")
            local clever_t = clever("t", "T")

            for key, key_specific_args in pairs {
                f = { opts = clever_f },
                F = { backward = true, opts = clever_f },
                t = { offset = -1, opts = clever_t },
                T = { backward = true, offset = 1, opts = clever_t },
            } do
                vim.keymap.set({ "n", "x", "o" }, key, function()
                    require("leap").leap(as_ft(key_specific_args))
                end)
            end
        end,
    },
}
