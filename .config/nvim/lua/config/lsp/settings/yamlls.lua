local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
    return
end

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
