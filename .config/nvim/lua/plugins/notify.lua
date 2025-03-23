return {
    {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require "notify"

            local icons = require "config.icons"

            notify.setup {
                -- Animation style (see below for details)
                stages = "fade_in_slide_out",

                -- Function called when a new window is opened, use for changing win settings/config
                on_open = nil,

                -- Function called when a window is closed
                on_close = nil,

                -- Render function for notifications. See notify-render()
                render = "default",

                -- Default timeout for notifications
                timeout = 175,

                -- For stages that change opacity this is treated as the highlight behind the window
                -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
                background_colour = "Normal",

                -- Minimum width for notification windows
                minimum_width = 10,

                -- Icons for the different levels
                icons = {
                    ERROR = icons.diagnostics.Error,
                    WARN = icons.diagnostics.Warning,
                    INFO = icons.diagnostics.Info,
                    DEBUG = icons.misc.Bug,
                    TRACE = icons.misc.Pencil,
                },
            }

            -- FIXME: Ugly hack to disable notify pop-up with 'No information available' when executing vim.lsp.buf.hover() in JS/TS files
            vim.notify = function(msg, ...)
                if msg:match "No information available" then
                    return
                end

                notify(msg, ...)
            end
        end,
    },
}
