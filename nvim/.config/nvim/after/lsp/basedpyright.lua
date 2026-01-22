return {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "all",
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticSeverityOverrides = {
                    reportAny = false,
                    reportExplicitAny = false,
                    reportMissingSuperCall = false,
                    reportUnusedCallResult = false,
                    reportCallIssue = false,
                    reportUninitializedInstanceVariable = false,
                    -- mypy takes care of import cycles
                    reportImportCycles = false,
                },
                inlayHints = {
                    genericTypes = true,
                    useTypingExtensions = true,
                },
            },
        },
    },
    -- root_dir = function(bufnr, on_dir)
    --     on_dir(require("lspconfig.util").root_pattern(unpack(root_files))())
    -- end,

    -- NOTE: Avoid starting the server each time pyproject.toml is encountered,
    -- as it gets annoying in with nested pyproject.toml files
    -- "pyproject.toml",
    root_markers = { ".git" },
}
