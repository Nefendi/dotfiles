local status_ok, _ = pcall(require, "vim-go")
if not status_ok then
	return
end

vim.g.go_def_mapping_enabled = 0
