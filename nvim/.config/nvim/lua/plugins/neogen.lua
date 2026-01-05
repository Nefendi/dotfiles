return {
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            local neogen = require "neogen"

            neogen.setup {
                enabled = true,
                snippet_engine = "luasnip",
                languages = {
                    python = {
                        template = {
                            annotation_convention = "google_docstrings",
                        },
                    },
                },
            }
        end,
    },
}
