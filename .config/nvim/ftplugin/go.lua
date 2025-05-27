local dap_go = require "dap-go"

dap_go.setup()

local which_key = require "which-key"

local mappings = {
    { "<leader>L", group = "Go", nowait = true, remap = false },
    { "<leader>LA", "<cmd>GoTestsAll<Cr>", desc = "Add All Tests", nowait = true, remap = false },
    { "<leader>LJ", "<cmd>GoTagAdd json<Cr>", desc = "Add JSON tags", nowait = true, remap = false },
    { "<leader>LY", "<cmd>GoTagAdd yaml<Cr>", desc = "Add YAML tags", nowait = true, remap = false },
    { "<leader>La", "<cmd>GoTestAdd<Cr>", desc = "Add Test", nowait = true, remap = false },
    { "<leader>Le", "<cmd>GoTestsExp<Cr>", desc = "Add Exported Tests", nowait = true, remap = false },
    { "<leader>Lf", "<cmd>GoGenerate %<Cr>", desc = "Go Generate File", nowait = true, remap = false },
    { "<leader>Lg", "<cmd>GoGenerate<Cr>", desc = "Go Generate", nowait = true, remap = false },
    {
        "<leader>Li",
        function()
            local interface = vim.fn.input "Implement Interface"
            vim.cmd("GoImpl " .. interface)
        end,
        desc = "Implement Interface",
        nowait = true,
        remap = false,
    },
    { "<leader>Lj", "<cmd>GoTagRm json<Cr>", desc = "Remove JSON tags", nowait = true, remap = false },
    { "<leader>Lt", "<cmd>GoMod tidy<cr>", desc = "Tidy", nowait = true, remap = false },
    { "<leader>Ly", "<cmd>GoTagRm yaml<Cr>", desc = "Remove YAML tags", nowait = true, remap = false },
    { "<leader>dT", "<cmd>lua require('dap-go').debug_test()<cr>", desc = "Debug Test", nowait = true, remap = false },
}

which_key.add(mappings)
