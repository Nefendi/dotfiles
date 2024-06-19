return {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticSeverityOverrides = {
                    reportAny = false,
                    reportMissingSuperCall = false,
                },
            },
        },
    },
}
