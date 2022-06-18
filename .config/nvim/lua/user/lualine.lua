local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 70
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "hint" },
	symbols = { error = " ", warn = " ", hint = " " },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local diff = {
	"diff",
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	diff_color = {
		added = { fg = "#98BE65" },
		modified = { fg = "#ECBE7B" },
		removed = { fg = "#EC5F67" },
	},
	color = { bg = "" },
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

local filename = {
	"filename",
	color = {},
	cond = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

-- Source: https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/lualine/components.lua
local spaces = {
	function()
		if not vim.api.nvim_buf_get_option(0, "expandtab") then
			return "Tab size: " .. vim.api.nvim_buf_get_option(0, "tabstop")
		end
		local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
		if size == 0 then
			size = vim.api.nvim_buf_get_option(0, "tabstop")
		end
		return "Spaces: " .. size
	end,
	cond = hide_in_width,
}

local fileformat = {
	"fileformat",
	icons_enabled = true,
}

local encoding = {
	"o:encoding",
	fmt = string.upper,
	cond = hide_in_width,
}

-- Source for LSP stuff: https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/lualine/components.lua
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local null_ls_sources__status_ok, null_ls_sources = pcall(require, "null-ls.sources")
if not null_ls_sources__status_ok then
	return
end

local function list_registered_null_ls_providers(file_type, kind)
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

local lsp = {
	function(msg)
		msg = msg or "LS Inactive"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			if type(msg) == "boolean" or #msg == 0 then
				return "LS Inactive"
			end
			return msg
		end
		local buf_ft = vim.bo.filetype
		local buf_client_names = {}

		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" then
				table.insert(buf_client_names, client.name)
			end
		end

		local ret = "[" .. table.concat(buf_client_names, ", ") .. " | "

		buf_client_names = {}

		local supported_formatters = list_registered_null_ls_providers(buf_ft, null_ls.methods.FORMATTING)
		vim.list_extend(buf_client_names, supported_formatters)

		local supported_linters = list_registered_null_ls_providers(buf_ft, null_ls.methods.DIAGNOSTICS)
		vim.list_extend(buf_client_names, supported_linters)

		return ret .. table.concat(buf_client_names, ", ") .. "]"
	end,
	icon = " LSP:",
	color = { gui = "bold" },
	cond = hide_in_width,
}

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch },
		lualine_c = { diff, filename, diagnostics },
		lualine_x = { lsp, spaces, encoding, fileformat, filetype },
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
})
