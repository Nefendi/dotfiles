return {
    -- Different command to disable the implicit --preview flag
    cmd = { "ruff", "server" },
    init_options = {
        settings = {
            lint = {
                preview = true,
            },
            format = {
                preview = false,
            },
        },
    },
}
