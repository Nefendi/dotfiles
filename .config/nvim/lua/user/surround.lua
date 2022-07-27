local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
	return
end

surround.setup({
	invalid_key_behavior = function()
		vim.notify("Invalid surround character", vim.log.levels.INFO)
	end,
})
