local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

-- NOTE: Do not forget to :TSInstall dap_repl for the highlights to work
require("nvim-dap-repl-highlights").setup()

local icons = require "user.icons"

dapui.setup {
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
        max_type_length = nil,
        max_value_lines = 100,
    },
}

vim.fn.sign_define("DapBreakpoint", { text = icons.misc.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = icons.misc.Bug, texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
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
