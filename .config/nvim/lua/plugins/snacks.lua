return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        init = function()
            _G.dd = function(...)
                Snacks.debug.inspect(...)
            end
            _G.bt = function()
                Snacks.debug.backtrace()
            end

            vim.print = _G.dd -- Override print to use snacks for `:=` command

            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    Snacks.toggle.dim():map "<leader>D"
                end,
            })
        end,
        keys = {
            {
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader> ",
                function()
                    Snacks.picker.files()
                end,
                desc = "Find Files",
            },
            {
                "<leader>C",
                function()
                    Snacks.picker.files { cwd = vim.fn.stdpath "config" }
                end,
                desc = "Find Config File",
            },
            {
                "<leader>P",
                function()
                    Snacks.picker.projects()
                end,
                desc = "Projects",
            },
            {
                "<leader>b",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>lR",
                function()
                    Snacks.picker.lsp_references()
                end,
                desc = "References",
            },
            {
                "gd",
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "Goto Definition",
            },
            {
                "<leader>.",
                function()
                    Snacks.explorer()
                end,
                desc = "File Explorer",
            },
            {
                "<leader>fc",
                function()
                    Snacks.picker.commands()
                end,
                desc = "Commands",
            },
            {
                "<leader>fH",
                function()
                    Snacks.picker.highlights()
                end,
                desc = "Highlights",
            },
            {
                "<leader>fM",
                function()
                    Snacks.picker.man()
                end,
                desc = "Man Pages",
            },
            {
                '<leader>f"',
                function()
                    Snacks.picker.registers()
                end,
                desc = "Registers",
            },
            {
                "<leader>fw",
                function()
                    Snacks.picker.grep_word()
                end,
                desc = "Visual selection or word",
                mode = { "n", "x" },
            },
            {
                "<leader>fC",
                function()
                    Snacks.picker.colorschemes()
                end,
                desc = "Colorschemes",
            },
            {
                "<leader>fb",
                function()
                    Snacks.picker.lines()
                end,
                desc = "Buffer Lines",
            },
            {
                "<leader>fh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help Pages",
            },
            {
                "<leader>fk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>fn",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "Notification History",
            },
            {
                "<leader>fr",
                function()
                    Snacks.picker.recent()
                end,
                desc = "Recent Files",
            },
            {
                "<leader>fs",
                function()
                    Snacks.picker.todo_comments()
                end,
                desc = "Todo",
            },
            {
                "<leader>fg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
        },
        ---@type snacks.Config
        opts = {
            styles = {
                notification = {
                    wo = { wrap = true },
                },
                lazygit = {
                    -- Fullscreen mode
                    width = 0,
                    height = 0,
                },
            },
            debug = { enabled = true },
            bufdelete = { enabled = true },
            image = { enabled = true },
            explorer = { enabled = true },
            picker = {
                enabled = true,
                exclude = {
                    -- General
                    ".git/",
                    ".idea/",
                    ".vscode/",
                    "htmlcov/",
                    ".direnv/",
                    ".cache/",

                    -- Vim
                    ".project.nvim",
                    ".null-ls-root",

                    -- JavaScript
                    "node_modules/",

                    -- Python
                    ".venv/",
                    "venv/",
                    ".mypy_cache/",
                    ".pytest_cache/",
                    "__pycache__",
                    ".ruff_cache/",
                    ".hypothesis/",

                    -- Rust
                    "target/",

                    -- C#
                    "obj/",

                    -- PHP
                    "vendor/",

                    -- Elixir
                    ".elixir_ls/",
                    "_build/",
                    "deps/",

                    -- Zig
                    ".zig-cache/",

                    -- Haskell
                    ".stack-work/",
                },
                sources = {
                    select = {
                        focus = "list",
                    },
                    notifications = {
                        focus = "list",
                        layout = {
                            preview = false,
                        },
                    },
                    explorer = {
                        hidden = true,
                        ignored = true,
                    },
                    projects = {
                        dev = { "~/dev", "~/projects", "~/Desktop", "~/Desktop/Repositories" },
                        patterns = {
                            ".git",
                            "_darcs",
                            ".hg",
                            ".bzr",
                            ".svn",
                            "package.json",
                            "go.mod",
                            "Cargo.toml",
                            "stack.yaml",
                            "mix.exs",
                            -- Custom marker file
                            ".project.nvim",
                        },
                    },
                    buffers = {
                        win = {
                            input = {
                                keys = {
                                    ["dd"] = { "bufdelete", mode = { "n" } },
                                },
                            },
                        },
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    lsp_references = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    lsp_definitions = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    grep = { hidden = true, ignored = true },
                    grep_word = { hidden = true, ignored = true },
                    lines = {
                        layout = {
                            -- The default ivy setting is great, but it messes up barbecue
                            preset = "default",
                            preview = "preview",
                        },
                    },
                    todo_comments = {
                        hidden = true,
                        ignored = true,
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    files = {
                        hidden = true,
                        ignored = true,
                    },
                },
            },
            statuscolumn = {
                enabled = true,
                left = { "mark", "git", "sign" },
                right = { "fold" },
                folds = {
                    open = true,
                    git_hl = false,
                },
            },
            scroll = { enabled = true },
            dim = { enabled = true },
            toggle = { enabled = true },
            notifier = { enabled = true },
            lazygit = { enabled = true },
            indent = {
                enabled = true,
                indent = {
                    char = "╎",
                },
                scope = {
                    hl = {
                        "SnacksIndent1",
                        "SnacksIndent2",
                        "SnacksIndent3",
                        "SnacksIndent4",
                        "SnacksIndent5",
                        "SnacksIndent6",
                        "SnacksIndent7",
                        "SnacksIndent8",
                    },
                    char = "╎",
                },
            },
            dashboard = {
                enabled = true,
                preset = {
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.picker.files()",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "p",
                            desc = "Find Project",
                            action = ":lua Snacks.picker.projects()",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.picker.recent()",
                        },
                        {
                            icon = " ",
                            key = "t",
                            desc = "Find Text",
                            action = ":lua Snacks.picker.grep()",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.picker.files { cwd = vim.fn.stdpath 'config' } ",
                        },
                        -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰒲 ",
                            key = "L",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                    {
                        align = "right",
                        text = {
                            {
                                [[


I swear, by my life and my love of it,
that I will never live for the sake of another man,
nor ask another man to live for mine.

                                       -- John Galt]],
                                hl = "SnacksDashboardKey",
                            },
                        },
                    },
                },
            },
        },
    },
}
