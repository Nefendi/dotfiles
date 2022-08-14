local status_ok, leap = pcall(require, "leap")
if not status_ok then
    return
end

vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })

leap.set_default_keymaps()
