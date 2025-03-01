local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
    return
end

vim.api.nvim_set_hl(0, "NvimSpectreUI", { fg = "#BB9AF7" })
vim.api.nvim_set_hl(0, "NvimSpectreSearch", { fg = "#E0AF68", bg = "#16161E" })
vim.api.nvim_set_hl(0, "NvimSpectreReplace", { fg = "#9ECE6A", bg = "#16161E" })

spectre.setup {
    default = {
        find = {
            cmd = "rg",
            options = { "ignore-case", "hidden" },
        },
    },
    is_insert_mode = true,
    highlight = {
        ui = "NvimSpectreUI",
        search = "NvimSpectreSearch",
        replace = "NvimSpectreReplace",
    },
}
