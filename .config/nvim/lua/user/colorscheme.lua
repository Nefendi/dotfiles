local colorscheme = "darkplus"

vim.g.onedarker_italic_keywords = true
vim.g.onedarker_italic_functions = false
vim.g.onedarker_italic_comments = true
vim.g.onedarker_italic_loops = true
vim.g.onedarker_italic_conditionals = true

vim.g.darkplus_italic_keywords = true
vim.g.darkplus_italic_functions = false
vim.g.darkplus_italic_comments = true
vim.g.darkplus_italic_loops = true
vim.g.darkplus_italic_conditionals = true

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    return
end
