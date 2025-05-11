local elixirls_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/") .. "bin/elixir-ls"

return {
    settings = {
        elixirLS = {
            enableTestLenses = true,
        },
    },
    cmd = { elixirls_path },
}
