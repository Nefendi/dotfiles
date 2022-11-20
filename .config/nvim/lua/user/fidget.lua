local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
    return
end

fidget.setup {
    text = {
        spinner = "dots",
    },
}

local comment_hl_group = vim.api.nvim_get_hl_by_name("Comment", true)

vim.api.nvim_set_hl(0, "FidgetTask", { fg = comment_hl_group.foreground })
