return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "windwp/nvim-ts-autotag", event = "BufReadPost" },
            { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPost" },
            { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPost" },
            { "RRethy/nvim-treesitter-endwise", event = "BufReadPost" },
            "IndianBoy42/tree-sitter-just",
            "vrischmann/tree-sitter-templ",
        },
        config = function()
            local configs = require "nvim-treesitter.configs"

            require("nvim-dap-repl-highlights").setup()
            require("tree-sitter-just").setup {}

            configs.setup {
                ensure_installed = "all", -- one of "all" or a list of languages
                ignore_install = { "" }, -- List of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                },
                autopairs = { enable = true },
                autotag = {
                    enable = true,
                    disable = { "markdown" },
                },
                endwise = {
                    enable = true,
                },
                indent = { enable = true, disable = { "python", "css", "markdown" } },
                playground = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["at"] = "@call.outer",
                            ["it"] = "@call.inner",
                            ["ap"] = "@parameter.outer",
                            ["ip"] = "@parameter.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["ai"] = "@conditional.outer",
                            ["ii"] = "@conditional.inner",
                            ["a/"] = "@comment.outer",
                            ["i/"] = "@comment.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            ["as"] = "@statement.outer",
                            ["aa"] = "@attribute.outer",
                            ["ia"] = "@attribute.inner",
                            ["aF"] = "@frame.outer",
                            ["iF"] = "@frame.inner",
                            ["ar"] = "@regex.outer",
                            ["ir"] = "@regex.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>;"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>'"] = "@parameter.inner",
                        },
                    },
                },
            }

            -- nvim-treesitter-context

            -- Nord palette
            -- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#3B4252" })
            -- vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#D8DEE9" })

            -- Darkplus palette
            -- vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#D4D4D4" })

            -- Onedarker palette
            -- vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#ABB2BF" })

            require("treesitter-context").setup {
                enable = true,
                max_lines = 0,
                min_window_height = 40, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            }

            local rainbow_delimiters = require "rainbow-delimiters"

            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
                blacklist = { "html" },
            }

            vim.g.skip_ts_context_commentstring_module = true

            require("ts_context_commentstring").setup {
                enable_autocmd = false,
                disable = { "markdown" },
            }
        end,
    },
}
