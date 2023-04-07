local status_ok, noice = pcall(require, "noice")
if not status_ok then
    return
end

noice.setup {
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        signature = {
            enabled = false,
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    routes = {
        -- To show macro recording messages
        {
            view = "notify",
            filter = { event = "msg_showmode" },
        },
        -- To disable messages about writing to files
        {
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
        -- To disable warnings about search hitting TOP or BOTTOM
        {
            filter = {
                event = "msg_show",
                kind = "wmsg",
                find = "search hit",
            },
            opts = { skip = true },
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
}
