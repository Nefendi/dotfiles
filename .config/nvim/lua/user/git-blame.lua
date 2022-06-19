local status_ok, _ = pcall(require, "gitblame")
if not status_ok then
	return
end

vim.g.gitblame_enabled = 0
vim.g.gitblame_message_template = "<sha> • <summary> • <date> • <author>"
vim.g.gitblame_highlight_group = "LineNr"
