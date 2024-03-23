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
        command_palette = true, -- position the cmdline and popupmenu together
        bottom_search = false, -- use a classic bottom cmdline for search
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
        -- To disable showing "Not information available" messages
        {
            view = "notify",
            filter = { find = "No information available" },
            opts = { skip = true },
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
        -- To disable messages about undoing changes
        {
            filter = {
                event = "msg_show",
                find = "more line",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                find = "line less",
            },
            opts = { skip = true },
        },
        -- To disable messages about redoing changes
        {
            filter = {
                event = "msg_show",
                find = " change;",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                find = " changes;",
            },
            opts = { skip = true },
        },
        -- To disable messages about multiline deletions
        {
            filter = {
                event = "msg_show",
                find = "fewer lines",
            },
            opts = { skip = true },
        },
        -- To disable messages about multiline yanks
        {
            filter = {
                event = "msg_show",
                find = "lines yanked",
            },
            opts = { skip = true },
        },
        -- To disable messages about moving lines
        {
            filter = {
                event = "msg_show",
                find = "lines moved",
            },
            opts = { skip = true },
        },
        -- To disable messages saying simply "true" and "false"
        {
            filter = {
                event = "msg_show",
                find = "true",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                find = "false",
            },
            opts = { skip = true },
        },
        -- To disable messages about indenting lines
        {
            filter = {
                event = "msg_show",
                find = "indent",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                find = "<ed",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                find = ">ed",
            },
            opts = { skip = true },
        },
        -- To disable annoying messages in C#
        {
            filter = {
                event = "msg_show",
                kind = "",
                find = "at Microsoft.FSharp.Control.Trampoline.Execute(FSharpFunc`2 firstAction) in",
            },
            opts = { skip = true },
        },
        -- To disable code_action and "Resolving code actions" in lsp_progress
        -- It gets super annoying when it triggers on every h,j,k,l key press
        {
            view = "mini",
            filter = {
                find = "code_action",
            },
            opts = { skip = true },
        },
        {
            view = "mini",
            filter = {
                find = "Resolving code actions",
            },
            opts = { skip = true },
        },
        -- To disable showing "Workspace edit @spec in Elixir"
        {
            view = "notify",
            filter = { find = "Workspace edit Add @spec" },
            opts = { skip = true },
        },
        -- To disable showing Cargo workspace reload information
        {
            view = "notify",
            filter = { find = "Reloading Cargo Workspace" },
            opts = { skip = true },
        },
        {
            view = "notify",
            filter = { find = "Cargo workspace reloaded" },
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
