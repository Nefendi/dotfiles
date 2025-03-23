return {
    {
        "nvim-pack/nvim-spectre",
        event = "BufReadPost",
        config = function()
            local spectre = require "spectre"

            vim.api.nvim_set_hl(0, "NvimSpectreUI", { fg = "#BB9AF7" })
            vim.api.nvim_set_hl(0, "NvimSpectreSearch", { fg = "#E0AF68", bg = "#16161E" })
            vim.api.nvim_set_hl(0, "NvimSpectreReplace", { fg = "#9ECE6A", bg = "#16161E" })

            spectre.setup {
                default = {
                    find = {
                        cmd = "rg",
                        options = { "ignore-case", "hidden" },
                    },
                },
                is_insert_mode = true,
                highlight = {
                    ui = "NvimSpectreUI",
                    search = "NvimSpectreSearch",
                    replace = "NvimSpectreReplace",
                },
            }
        end,
    },
}
