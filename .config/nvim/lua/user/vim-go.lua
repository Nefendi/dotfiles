vim.g.go_def_mapping_enabled = 0
vim.g.go_fmt_autosave = 0
vim.g.go_imports_autosave = 0
vim.g.go_gopls_enabled = 0
vim.g.go_diagnostics_level = 0
vim.g.go_metalinter_enabled = 0

local status_ok, _ = pcall(require, "vim-go")
if not status_ok then
	return
end
