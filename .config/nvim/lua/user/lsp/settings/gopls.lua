return {
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            codelenses = {
                generate = true,
                gc_details = true,
                test = true,
                tidy = true,
            },
            gofumpt = true,
        },
    },
}
