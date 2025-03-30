return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = "ToggleTerm",
        opts = {
            open_mapping = [[<m-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            start_in_insert = true,
            direction = "float",
            close_on_exit = true,
            float_opts = {
                border = "curved",
            },
            highlights = {
                FloatBorder = {
                    guifg = "#27a1b9",
                    guibg = "#16161e",
                },
            },
        },
        keys = {
            {
                "<m-1>",
                "<cmd>1ToggleTerm<cr>",
                desc = "Toggle floating terminal 1",
                mode = { "n", "t" },
            },
            {
                "<m-2>",
                "<cmd>2ToggleTerm<cr>",
                desc = "Toggle floating terminal 2",
                mode = { "n", "t" },
            },
            {
                "<m-3>",
                "<cmd>3ToggleTerm<cr>",
                desc = "Toggle floating terminal 3",
                mode = { "n", "t" },
            },
            {
                "<m-4>",
                "<cmd>4ToggleTerm<cr>",
                desc = "Toggle floating terminal 4",
                mode = { "n", "t" },
            },
        },
    },
}
