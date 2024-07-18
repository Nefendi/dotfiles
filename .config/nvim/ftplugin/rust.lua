local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

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

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local mappings = {
    { "<leader>L", group = "Rust", nowait = true, remap = false },
    { "<leader>Lc", "<cmd>RustLsp openCargo<Cr>", desc = "Open Cargo", nowait = true, remap = false },
    { "<leader>Le", "<cmd>RustLsp expandMacro<Cr>", desc = "Expand Macro", nowait = true, remap = false },
    { "<leader>Lg", "<cmd>RustLsp crateGraph<Cr>", desc = "View Crate Graph", nowait = true, remap = false },
    { "<leader>Lp", "<cmd>RustLsp parentModule<Cr>", desc = "Parent Module", nowait = true, remap = false },
    { "<leader>Lr", "<cmd>RustLsp runnables<Cr>", desc = "Runnables", nowait = true, remap = false },
    { "<leader>Lw", "<cmd>RustLsp reloadWorkspace<Cr>", desc = "Reload Workspace", nowait = true, remap = false },
}

which_key.add(mappings)
