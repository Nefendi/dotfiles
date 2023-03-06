return {
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            gofumpt = true,
            codelenses = {
                generate = true,
                gc_details = true,
                test = true,
                tidy = true,
            },
        },
    },
}
