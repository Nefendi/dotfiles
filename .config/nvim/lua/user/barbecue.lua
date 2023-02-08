local status_ok, barbecue = pcall(require, "barbecue")
if not status_ok then
    return
end

barbecue.setup {
    show_modified = true,
    exclude_filetypes = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "gitcommit",
        "DressingSelect",
        "Jaq",
        "glowpreview",
        "dap-repl",
        "dap-terminal",
        "dapui_console",
        "lab",
        "",
    },
}
