local dap_go = require "dap-go"

dap_go.setup()

local which_key = require "which-key"

local mappings = {
    { "<leader>L", group = "Go", nowait = true },
    { "<leader>LA", "<cmd>GoTestsAll<Cr>", desc = "Add All Tests", nowait = true },
    { "<leader>LJ", "<cmd>GoTagAdd json<Cr>", desc = "Add JSON tags", nowait = true },
    { "<leader>LY", "<cmd>GoTagAdd yaml<Cr>", desc = "Add YAML tags", nowait = true },
    { "<leader>La", "<cmd>GoTestAdd<Cr>", desc = "Add Test", nowait = true },
    { "<leader>Le", "<cmd>GoTestsExp<Cr>", desc = "Add Exported Tests", nowait = true },
    { "<leader>Lf", "<cmd>GoGenerate %<Cr>", desc = "Go Generate File", nowait = true },
    { "<leader>Lg", "<cmd>GoGenerate<Cr>", desc = "Go Generate", nowait = true },
    {
        "<leader>Li",
        function()
            local interface = vim.fn.input "Implement Interface"
            vim.cmd("GoImpl " .. interface)
        end,
        desc = "Implement Interface",
        nowait = true,
    },
    { "<leader>Lj", "<cmd>GoTagRm json<Cr>", desc = "Remove JSON tags", nowait = true },
    { "<leader>Lt", "<cmd>GoMod tidy<cr>", desc = "Tidy", nowait = true },
    { "<leader>Ly", "<cmd>GoTagRm yaml<Cr>", desc = "Remove YAML tags", nowait = true },
    { "<leader>dT", "<cmd>lua require('dap-go').debug_test()<cr>", desc = "Debug Test", nowait = true },
}

which_key.add(mappings)
