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
                    Snacks.toggle.dim():map "<leader>od"
                    Snacks.toggle.zen():map "<leader>oz"
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>ow"
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>or"

                    Snacks.toggle({
                        name = "Completion",
                        get = function()
                            return vim.g.cmp_active
                        end,
                        set = function(state)
                            vim.g.cmp_active = state
                        end,
                    }):map "<leader>oc"

                    Snacks.toggle({
                        name = "Format On Save",
                        get = function()
                            return vim.g.format_on_save_enabled
                        end,
                        set = function(state)
                            vim.g.format_on_save_enabled = state
                        end,
                    }):map "<leader>lF"

                    Snacks.toggle({
                        name = "Inlay Hints",
                        get = function()
                            return vim.lsp.inlay_hint.is_enabled()
                        end,
                        set = function(state)
                            vim.lsp.inlay_hint.enable(state)
                        end,
                    }):map "<leader>lh"

                    Snacks.toggle({
                        name = "LSP Virtual Lines",
                        get = function()
                            return vim.diagnostic.config().virtual_lines
                        end,
                        set = function(state)
                            vim.diagnostic.config { virtual_lines = state }
                        end,
                    }):map "<leader>lv"

                    Snacks.toggle({
                        name = "LSP Diagnostics",
                        get = function()
                            return vim.diagnostic.is_enabled()
                        end,
                        set = function(state)
                            vim.diagnostic.enable(state)
                        end,
                    }):map "<leader>lV"
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
                "<leader>gr",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Repo Website",
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
                "<leader>u",
                function()
                    Snacks.picker.undo()
                end,
                desc = "Undo History",
            },
            {
                "gr",
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
                "gD",
                function()
                    Snacks.picker.lsp_declarations()
                end,
                desc = "Goto Declaration",
            },
            {
                "gI",
                function()
                    Snacks.picker.lsp_implementations()
                end,
                desc = "Goto Implementation",
            },
            {
                "gy",
                function()
                    Snacks.picker.lsp_type_definitions()
                end,
                desc = "Goto T[y]pe Definition",
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
                "<leader>fm",
                function()
                    Snacks.picker.marks()
                end,
                desc = "Marks",
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
            {
                "<leader>fi",
                function()
                    Snacks.picker.icons()
                end,
                desc = "Icons",
            },
            {
                "<leader>fj",
                function()
                    Snacks.picker.jumps()
                end,
                desc = "Jumps",
            },
            {
                "<leader>gb",
                function()
                    Snacks.picker.git_branches()
                end,
                desc = "Git Branches",
            },
            {
                "<leader>lD",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<leader>ld",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "Buffer Diagnostics",
            },
            {
                "<leader>ls",
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = "LSP Symbols",
            },
            {
                "<leader>lS",
                function()
                    Snacks.picker.lsp_workspace_symbols()
                end,
                desc = "LSP Workspace Symbols",
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
            undo = { enabled = true },
            bigfile = { enabled = true },
            gitbrowse = { enabled = true },
            zen = {
                enabled = true,
                toggles = {
                    dim = true,
                    git_signs = false,
                    mini_diff_signs = false,
                    diagnostics = true,
                    inlay_hints = true,
                },
            },
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

                    -- Syncthing
                    ".stfolder/",

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

                    -- Obsidian
                    ".obsidian/",
                },
                win = {
                    input = {
                        keys = {
                            ["<a-s>"] = { "flash", mode = { "n", "i" } },
                            ["s"] = { "flash" },
                        },
                    },
                },
                actions = {
                    flash = function(picker)
                        require("flash").jump {
                            pattern = "^",
                            label = { after = { 0, 0 } },
                            search = {
                                mode = "search",
                                exclude = {
                                    function(win)
                                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                                    end,
                                },
                            },
                            action = function(match)
                                local idx = picker.list:row2idx(match.pos[1])
                                picker.list:_move(idx, true, true)
                            end,
                        }
                    end,
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
                        confirm = "focus_preview",
                    },
                    explorer = {
                        hidden = true,
                    },
                    undo = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    marks = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    projects = {
                        dev = { "~/dev", "~/projects", "~/Desktop", "~/Desktop/Repositories" },
                        recent = false,
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
                    lsp_declarations = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    lsp_type_definitions = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    lsp_implementations = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    grep = {
                        hidden = true,
                        win = {
                            input = {
                                keys = {
                                    ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
                                },
                            },
                            list = {
                                keys = {
                                    ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
                                },
                            },
                        },
                    },
                    grep_word = {
                        hidden = true,
                        win = {
                            input = {
                                keys = {
                                    ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
                                },
                            },
                            list = {
                                keys = {
                                    ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
                                },
                            },
                        },
                    },
                    lines = {
                        layout = {
                            -- The default ivy setting is great, but it messes up barbecue
                            preset = "default",
                            preview = "preview",
                        },
                    },
                    todo_comments = {
                        hidden = true,
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                    files = {
                        hidden = true,
                    },
                    jumps = {
                        on_show = function(_picker)
                            vim.cmd "stopinsert"
                        end,
                    },
                },
            },
            statuscolumn = {
                enabled = true,
                left = { "mark", "sign" },
                right = { "fold", "git" },
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
