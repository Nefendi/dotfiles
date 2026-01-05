return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        opts = {
            show_success_message = true,
        },
        config = function(_, opts)
            require("refactoring").setup(opts)
        end,
        keys = {
            { "<leader>R", desc = "Refactoring", mode = { "n", "x" } },
            {
                "<leader>Re",
                "<CMD>Refactor extract<CR>",
                mode = { "n", "x" },
                desc = "Extract Function",
            },
            {
                "<leader>Rf",
                "<CMD>Refactor extract_to_file<CR>",
                mode = { "n", "x" },
                desc = "Extract Function to File",
            },
            {
                "<leader>Rv",
                "<CMD>Refactor extract_var<CR>",
                mode = { "n", "x" },
                desc = "Extract Variable",
            },
            {
                "<leader>Ri",
                "<CMD>Refactor inline_var<CR>",
                mode = { "n", "x" },
                desc = "Inline Variable",
            },
            {
                "<leader>RI",
                "<CMD>Refactor inline_func<CR>",
                mode = { "n", "x" },
                desc = "Inline Function",
            },
            {
                "<leader>Rb",
                "<CMD>Refactor extract_block<CR>",
                mode = { "n", "x" },
                desc = "Extract Block",
            },
            {
                "<leader>RB",
                "<CMD>Refactor extract_block_to_file<CR>",
                mode = { "n", "x" },
                desc = "Extract Block to File",
            },
            {
                "<leader>Rr",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = { "n", "x" },
                desc = "Select Refactor",
            },
        },
    },
}
