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
                    reportMissingSuperCall = false,
                    reportUnusedCallResult = false,
                    reportCallIssue = false,
                    reportUninitializedInstanceVariable = false,
                },
            },
        },
    },
}
