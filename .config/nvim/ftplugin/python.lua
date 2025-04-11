local dap_python = require "dap-python"

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
dap_python.test_runner = "pytest"

local which_key = require "which-key"

local mappings = {
    {
        "<leader>dm",
        "<cmd>lua require('dap-python').test_class()<cr>",
        desc = "Test Class",
        nowait = true,
        remap = false,
    },
    {
        "<leader>dT",
        "<cmd>lua require('dap-python').test_method()<cr>",
        desc = "Test Method",
        nowait = true,
        remap = false,
    },
}

local vmappings = {
    { "<leader>d", group = "Debug", mode = "v", nowait = true, remap = false },
    {
        "<leader>ds",
        "<esc><cmd>lua require('dap-python').debug_selection()<cr>",
        desc = "Debug Selection",
        mode = "v",
        nowait = true,
        remap = false,
    },
}

which_key.add(mappings)
which_key.add(vmappings)
