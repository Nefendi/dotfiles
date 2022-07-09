-- Source: https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/functions.lua

local M = {}

function M.isempty(s)
	return s == nil or s == ""
end

function M.get_buf_option(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	vim.notify(option .. " set to " .. tostring(value))
end

function M.list_registered_null_ls_providers(file_type, kind)
	local null_ls_sources__status_ok, null_ls_sources = pcall(require, "null-ls.sources")
	if not null_ls_sources__status_ok then
		return
	end

	local available_sources = null_ls_sources.get_available(file_type)

	local registered = {}
	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end
	return registered[kind] or {}
end

function M.contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

return M