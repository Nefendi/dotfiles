local status_ok, statuscol = pcall(require, "statuscol")
if not status_ok then
    return
end

local builtin = require "statuscol.builtin"

statuscol.setup {
    setopt = true,
    segments = {
        -- Sign + " "
        { text = { "%s", " " }, click = "v:lua.ScSa" },
        -- Line number + " "
        {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
        },
        -- Foldcolumn + " "
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
    },
    ft_ignore = {
        "help",
        "spectre_panel",
        "neotest-attach",
        "neotest-summary",
    },
}
