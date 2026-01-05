return {
    cmd = { "golangci-lint-langserver", "-nolintername" },
    init_options = {
        command = {
            "golangci-lint",
            "run",
            "--output.json.path=stdout",
            "--show-stats=false",
        },
    },
}
