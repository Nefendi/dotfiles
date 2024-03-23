local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

dap.adapters.mix_task = {
    type = "executable",
    command = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/elixir-ls/debug_adapter.sh"),
    args = {},
}

dap.configurations.elixir = {
    {
        type = "mix_task",
        name = "mix test",
        task = "test",
        taskArgs = { "--trace" },
        request = "launch",
        startApps = true, -- for Phoenix projects
        projectDir = "${workspaceFolder}",
        requireFiles = {
            "test/**/test_helper.exs",
            "test/**/*_test.exs",
        },
    },
}
