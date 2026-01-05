return {
    {
        "dnlhc/glance.nvim",
        cmd = "Glance",
        keys = {
            { "gp", desc = "Peek", mode = { "n", "v" } },
            {
                "gpp",
                "<CMD>Glance definitions<CR>",
                mode = { "n", "v" },
                desc = "Peek Definition",
            },
            {
                "gpr",
                "<CMD>Glance references<CR>",
                mode = { "n", "v" },
                desc = "Peek References",
            },
            {
                "gpy",
                "<CMD>Glance type_definitions<CR>",
                mode = { "n", "v" },
                desc = "Peek T[y]pe Definitions",
            },
            {
                "gpI",
                "<CMD>Glance implementations<CR>",
                mode = { "n", "v" },
                desc = "Peek Implementations",
            },
        },
        opts = {
            border = {
                enable = true,
            },
        },
    },
}
