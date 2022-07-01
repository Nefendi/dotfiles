local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
	return
end

lsp_signature.setup({
	floating_window = false,
	floating_window_above_cur_line = false,
	hint_prefix = " ",
	hint_scheme = "Comment",
	doc_lines = 0,
	max_width = 120,
})
