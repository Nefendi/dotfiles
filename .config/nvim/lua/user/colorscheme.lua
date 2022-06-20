local colorscheme = "gruvbox"

vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_sign_column = "bg0"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
