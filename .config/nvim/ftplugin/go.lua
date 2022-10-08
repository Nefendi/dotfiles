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
        name = "Go",
        -- i = { "<cmd>GoImpl<Cr>", "Implement Interface" },
        t = { "<cmd>GoMod tidy<cr>", "Tidy" },
        a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
        A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
        e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
        g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
        f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
        J = { "<cmd>GoTagAdd json<Cr>", "Add JSON tags" },
        j = { "<cmd>GoTagRm json<Cr>", "Remove JSON tags" },
        Y = { "<cmd>GoTagAdd yaml<Cr>", "Add YAML tags" },
        y = { "<cmd>GoTagRm yaml<Cr>", "Remove YAML tags" },
    },
    d = {
        T = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" },
    },
}

which_key.register(mappings, opts)
