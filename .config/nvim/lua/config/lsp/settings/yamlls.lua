local schemastore = require "schemastore"

return {
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
            },
            schemas = schemastore.yaml.schemas {
                ignore = {
                    -- GitHub Actions LS takes care of that
                    "GitHub Workflow",
                },
            },
        },
    },
}
