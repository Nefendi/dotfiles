return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                signature = {
                    enabled = true,
                },
            },
            presets = {
                command_palette = true, -- position the cmdline and popupmenu together
                bottom_search = false, -- use a classic bottom cmdline for search
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "fewer lines" },
                            { find = "yanked" },
                        },
                    },
                    view = "mini",
                },
                {
                    filter = {
                        any = {
                            { find = "Checking document ltex" },
                            { find = "No information available" },
                        },
                    },
                    opts = { skip = true },
                },
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
            },
            views = {
                hover = {
                    size = {
                        -- FIXME: Ugly hack to make hover popups not extend the border on my monitor.
                        -- Maybe this can be nicer if some day percentages are supported.
                        -- Something like '90%' or '95%' could work.
                        max_width = 100,
                    },
                },
            },
            config = function(_, opts)
                -- HACK: noice shows messages from before it was enabled,
                -- but this is not ideal when Lazy is installing plugins,
                -- so clear the messages in this case.
                if vim.o.filetype == "lazy" then
                    vim.cmd [[messages clear]]
                end
                require("noice").setup(opts)
            end,
        },
    },
}
