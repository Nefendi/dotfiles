return {
    -- Different command to disable the implicit --preview flag
    cmd = { "ruff", "server" },
    init_options = {
        settings = {
            lint = {
                preview = false,
            },
            format = {
                preview = false,
            },
        },
    },
}
