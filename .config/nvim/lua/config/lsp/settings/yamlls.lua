local schemastore = require "schemastore"

return {
    settings = {
        schemaStore = {
            enable = false,
        },
        yaml = {
            schemas = schemastore.yaml.schemas(),
        },
    },
}
