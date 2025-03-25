return {
    settings = {
        Lua = {
            type = {
                -- weakUnionCheck = true,
                -- weakNilCheck = true,
                -- castNumberToInteger = true,
            },
            format = {
                enable = false,
            },
            hint = {
                enable = true,
                arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                await = true,
                paramName = "Disable", -- "All", "Literal", "Disable"
                paramType = true,
                semicolon = "Disable", -- "All", "SameLine", "Disable"
                setType = true,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
