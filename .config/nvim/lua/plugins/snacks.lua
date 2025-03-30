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
            picker = {
                enabled = true,
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
                            action = "<cmd> Telescope find_files <CR>",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "p",
                            desc = "Find Project",
                            action = ":lua require('telescope').extensions.projects.projects()",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = "<cmd> Telescope oldfiles <CR>",
                        },
                        {
                            icon = " ",
                            key = "t",
                            desc = "Find Text",
                            action = ":lua require('config.multigrep').live_multigrep()",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }",
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
