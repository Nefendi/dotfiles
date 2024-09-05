local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
    return
end

local neotest_python_status_ok, neotest_python = pcall(require, "neotest-python")
if not neotest_python_status_ok then
    return
end

local neotest_go_status_ok, neotest_go = pcall(require, "neotest-go")
if not neotest_go_status_ok then
    return
end

local neotest_jest_status_ok, neotest_jest = pcall(require, "neotest-jest")
if not neotest_jest_status_ok then
    return
end

local neotest_vitest_status_ok, neotest_vitest = pcall(require, "neotest-vitest")
if not neotest_vitest_status_ok then
    return
end

local neotest_elixir_status_ok, neotest_elixir = pcall(require, "neotest-elixir")
if not neotest_elixir_status_ok then
    return
end

local neotest_zig_status_ok, neotest_zig = pcall(require, "neotest-zig")
if not neotest_zig_status_ok then
    return
end

neotest.setup {
    adapters = {
        require "rustaceanvim.neotest",
        neotest_python,
        neotest_go,
        neotest_jest,
        neotest_vitest,
        neotest_elixir,
        neotest_zig,
    },
    output_panel = {
        open = "botright split | resize 30",
    },
    floating = {
        max_height = 0.8,
        max_width = 0.8,
    },
    quickfix = {
        open = false,
    },
}
