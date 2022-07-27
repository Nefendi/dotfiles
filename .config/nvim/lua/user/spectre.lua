local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
    return
end

spectre.setup {
    default = {
        find = {
            cmd = "rg",
            options = { "ignore-case", "hidden" },
        },
    },
    is_insert_mode = true,
}
