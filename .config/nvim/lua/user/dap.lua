local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

local dap_python_status_ok, dap_python = pcall(require, "dap-python")
if not dap_python_status_ok then
    return
end

local dap_go_ok, dap_go = pcall(require, "dap-go")
if not dap_go_ok then
    return
end

local icons = require "user.icons"

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

-- Python
dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
dap_python.test_runner = "pytest"

-- Go
dap_go.setup()

dapui.setup {
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = vim.fn.has "nvim-0.7",
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
}

vim.fn.sign_define(
    "DapBreakpoint",
    { text = icons.misc.SmallDot, texthl = "DiagnosticSignError", linehl = "", numhl = "" }
)

vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = icons.misc.SmallDot, texthl = "DiagnosticSignHint", linehl = "", numhl = "" }
)

vim.fn.sign_define("DapStopped", {
    text = icons.ui.BoldArrowRight,
    texthl = "DiagnosticSignInfo",
    linehl = "DiagnosticUnderlineInfo",
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
