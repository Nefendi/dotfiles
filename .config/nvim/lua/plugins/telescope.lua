return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local telescope = require "telescope"

            local actions = require "telescope.actions"

            local icons = require "config.icons"

            telescope.setup {
                defaults = {
                    winblend = 0,
                    prompt_prefix = icons.ui.Telescope .. " ",
                    selection_caret = icons.ui.EnterArrow .. " ",
                    path_display = { "truncate" },
                    file_ignore_patterns = {
                        -- General
                        "%.git/",
                        "%.idea/",
                        "%.vscode/",
                        "htmlcov/",
                        "%.direnv/",
                        "%.cache/",

                        -- Vim
                        "%.project%.nvim",
                        "%.null%-ls%-root",

                        -- JavaScript
                        "node_modules/",

                        -- Python
                        "%.venv/",
                        "venv/",
                        "%.mypy_cache/",
                        "%.pytest_cache/",
                        "__pycache__",
                        "%.ruff_cache/",
                        "%.hypothesis/",

                        -- Rust
                        "target/",

                        -- C#
                        "obj/",

                        -- PHP
                        "vendor/",

                        -- Elixir
                        "%.elixir_ls/",
                        "_build/",
                        "deps/",

                        -- Zig
                        "%.zig%-cache/",

                        -- Haskell
                        "%.stack%-work/",
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "-uu",
                    },
                    mappings = {
                        i = {
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-h>"] = actions.which_key,
                        },
                        n = {
                            ["q"] = actions.close,
                            ["dd"] = actions.delete_buffer,
                            ["s"] = actions.select_horizontal,
                            ["v"] = actions.select_vertical,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "fd",
                            "--type=f",
                            "-uu",
                        },
                        theme = "dropdown",
                        previewer = false,
                    },
                    live_grep = {
                        theme = "dropdown",
                    },
                    grep_string = {
                        theme = "dropdown",
                        only_sort_text = true,
                    },
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                        initial_mode = "normal",
                    },
                    current_buffer_fuzzy_find = {
                        theme = "dropdown",
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                },
            }

            telescope.load_extension "projects"
            telescope.load_extension "fzf"
        end,
    },
}
