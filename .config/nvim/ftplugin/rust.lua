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

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    L = {
        name = "Rust",
        r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
        e = { "<cmd>RustLsp expandMacro<Cr>", "Expand Macro" },
        c = { "<cmd>RustLsp openCargo<Cr>", "Open Cargo" },
        p = { "<cmd>RustLsp parentModule<Cr>", "Parent Module" },
        g = { "<cmd>RustLsp crateGraph<Cr>", "View Crate Graph" },
        w = { "<cmd>RustLsp reloadWorkspace<Cr>", "Reload Workspace" },
    },
}

which_key.register(mappings, opts)
