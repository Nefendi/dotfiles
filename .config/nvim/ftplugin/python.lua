local dap_python_status_ok, dap_python = pcall(require, "dap-python")
if not dap_python_status_ok then
    return
end

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
dap_python.test_runner = "pytest"

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    d = {
        m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" },
        f = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
    },
}

local vmappings = {
    d = {
        name = "Debug",
        s = { "<esc><cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
    },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
