return {
    {
        "olexsmir/gopher.nvim",
        ft = { "go", "gomod", "gowork", "gosum" },
        config = function()
            local gopher = require "gopher"

            gopher.setup {
                commands = {
                    go = "go",
                    gomodifytags = "gomodifytags",
                    gotests = "gotests",
                    impl = "impl",
                    iferr = "iferr",
                },
            }
        end,
    },
}
