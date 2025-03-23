return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "rcarriga/cmp-dap",
            "LiadOz/nvim-dap-repl-highlights",
        },
        config = function()
            local dap = require "dap"

            local dapui = require "dapui"

            local icons = require "config.icons"

            dapui.setup {
                controls = {
                    element = "repl",
                    enabled = true,
                    icons = {
                        disconnect = "",
                        pause = "",
                        play = "",
                        run_last = "",
                        step_back = "",
                        step_into = "",
                        step_out = "",
                        step_over = "",
                        terminate = "",
                    },
                },
                element_mappings = {},
                force_buffers = true,
                auto_open = true,
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                expand_lines = true,
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.33 },
                            { id = "breakpoints", size = 0.17 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        size = 0.33,
                        position = "right",
                    },
                    {
                        elements = {
                            { id = "repl", size = 0.45 },
                            { id = "console", size = 0.55 },
                        },
                        size = 0.27,
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = 0.9,
                    max_width = 0.5,
                    border = "rounded",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    indent = 1,
                    max_value_lines = 100,
                },
            }

            vim.fn.sign_define(
                "DapBreakpoint",
                { text = icons.misc.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )

            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = icons.misc.Bug, texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
            )

            vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#BBBBBB" })
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = icons.misc.Bug, texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
            )

            vim.fn.sign_define(
                "DapLogPoint",
                { text = icons.misc.Diamond, texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )

            vim.fn.sign_define("DapStopped", {
                text = icons.ui.BoldArrowRight,
                texthl = "DiagnosticSignInfo",
                linehl = "Visual",
                numhl = "DiagnosticSignInfo",
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
}
