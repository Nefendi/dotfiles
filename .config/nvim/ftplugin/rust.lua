local dap = require "dap"

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
local codelldb_adapter = {
    type = "server",
    port = "${port}",
    executable = {
        command = mason_path .. "bin/codelldb",
        args = { "--port", "${port}" },
    },
}

dap.adapters.codelldb = codelldb_adapter
dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

local which_key = require "which-key"

local mappings = {
    { "<leader>L", group = "Rust", nowait = true },
    { "<leader>Lc", "<cmd>RustLsp openCargo<Cr>", desc = "Open Cargo", nowait = true },
    { "<leader>Le", "<cmd>RustLsp expandMacro<Cr>", desc = "Expand Macro", nowait = true },
    { "<leader>Lg", "<cmd>RustLsp crateGraph<Cr>", desc = "View Crate Graph", nowait = true },
    { "<leader>Lp", "<cmd>RustLsp parentModule<Cr>", desc = "Parent Module", nowait = true },
    { "<leader>Lr", "<cmd>RustLsp runnables<Cr>", desc = "Runnables", nowait = true },
    { "<leader>Lw", "<cmd>RustLsp reloadWorkspace<Cr>", desc = "Reload Workspace", nowait = true },
}

which_key.add(mappings)
