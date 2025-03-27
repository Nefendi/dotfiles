local icons = require "config.icons"

local default_sources = { "lazydev", "lsp", "path", "snippets", "buffer", "crates", "npm" }
local debug_sources = vim.list_extend(vim.deepcopy(default_sources), { "dap" })

vim.g.cmp_active = true

vim.api.nvim_set_hl(0, "_BlinkCmpItemSourceName", { fg = "#565f89" })
vim.api.nvim_set_hl(0, "_BlinkCmpItemKindPackage", { fg = "#F64D00" })

return {
    {
        "saghen/blink.compat",
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = "*",
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "David-Kunz/cmp-npm",
            "Saecki/crates.nvim",
            "rcarriga/cmp-dap",
        },
        event = "InsertEnter",

        -- use a release tag to download pre-built binaries
        version = "1.*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            enabled = function()
                return vim.g.cmp_active and (vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer())
            end,
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = "enter",

                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-l>"] = { "snippet_forward", "fallback" },
                ["<C-h>"] = { "snippet_backward", "fallback" },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },
            cmdline = {
                keymap = {
                    ["<Tab>"] = { "accept" },
                    ["<CR>"] = { "accept_and_enter", "fallback" },
                    ["<C-j>"] = { "select_next", "fallback" },
                    ["<C-k>"] = { "select_prev", "fallback" },
                },
                completion = {
                    menu = {
                        auto_show = true,
                    },
                },
            },
            completion = {
                trigger = {
                    show_on_blocked_trigger_characters = function(ctx)
                        local default = { " ", "\n", "\t" }

                        if vim.bo.filetype == "python" then
                            table.insert(default, ":")
                        end

                        return default
                    end,
                },
                documentation = { auto_show = true, window = { border = "rounded" } },
                ghost_text = { enabled = true },
                menu = {
                    border = "rounded",
                    draw = {
                        components = {
                            source_name = {
                                text = function(ctx)
                                    return "(" .. ctx.source_name .. ")"
                                end,
                                highlight = function(ctx)
                                    return "_BlinkCmpItemSourceName"
                                end,
                            },
                        },
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                            { "source_name" },
                        },
                    },
                },
                list = {
                    selection = {
                        preselect = function(ctx)
                            return ctx.mode ~= "cmdline"
                        end,
                        auto_insert = false,
                    },
                },
            },
            snippets = { preset = "luasnip" },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = default_sources,
                per_filetype = {
                    ["dap-repl"] = debug_sources,
                    dapui_watches = debug_sources,
                    dapui_hover = debug_sources,
                },
                providers = {
                    cmdline = {
                        min_keyword_length = function(ctx)
                            -- when typing a command, only show when the keyword is 3 characters or longer
                            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                                return 3
                            end
                            return 0
                        end,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    dap = {
                        name = "dap",
                        module = "blink.compat.source",
                        enabled = function()
                            return require("cmp_dap").is_dap_buffer()
                        end,
                    },
                    crates = {
                        name = "crates",
                        module = "blink.compat.source",
                        transform_items = function(ctx, items)
                            for _, item in ipairs(items) do
                                item.kind_icon = icons.misc.Package
                                item.kind_name = "Package"
                                item.kind_hl = "_BlinkCmpItemKindPackage"
                            end

                            return items
                        end,
                    },
                    npm = {
                        name = "npm",
                        module = "blink.compat.source",
                        transform_items = function(ctx, items)
                            for _, item in ipairs(items) do
                                item.kind_icon = icons.misc.Package
                                item.kind_name = "Package"
                                item.kind_hl = "_BlinkCmpItemKindPackage"
                            end

                            return items
                        end,
                    },
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
