-- local colorscheme = "onedarker"

-- vim.g.onedarker_italic_keywords = true
-- vim.g.onedarker_italic_functions = false
-- vim.g.onedarker_italic_comments = true
-- vim.g.onedarker_italic_loops = true
-- vim.g.onedarker_italic_conditionals = true

-- vim.g.darkplus_italic_keywords = true
-- vim.g.darkplus_italic_functions = false
-- vim.g.darkplus_italic_comments = true
-- vim.g.darkplus_italic_loops = true
-- vim.g.darkplus_italic_conditionals = true

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

-- if not status_ok then
--     return
-- end

local status_ok, nord = pcall(require, "nord")

if not status_ok then
    return
end

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true

nord.set()

-- require("nordic").colorscheme {
--     underline_option = "undercurl",
--     italic = false,
--     italic_comments = true,
--     minimal_mode = false,
--     alternate_backgrounds = true,
-- }
