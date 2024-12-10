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
            },
        },
    },
}
