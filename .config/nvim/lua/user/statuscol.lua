local status_ok, statuscol = pcall(require, "statuscol")
if not status_ok then
    return
end

statuscol.setup {
    foldfunc = "builtin",
    setopt = true,
    order = "SsNsFs",
    ft_ignore = {
        "help",
        "spectre_panel",
    },
}
