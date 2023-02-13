return {
    cmd = { "golangci-lint-langserver", "-nolintername" },
    init_options = {
        command = {
            "golangci-lint",
            "run",
            "--out-format",
            "json",
            "--issues-exit-code=1",
        },
    },
}
