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
    -- NOTE: Avoid starting the server each time pyproject.toml is encountered,
    -- as it gets annoying in with nested pyproject.toml files
    root_markers = { ".git" },
}
