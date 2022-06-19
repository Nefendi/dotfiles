-- Sources for spaces, LSP, Python env and Tresitter components: https://github.com/LunarVim/LunarVim

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 70
end

local green = "#98BE65"
local yellow = "#ECBE7B"
local red = "#EC5F67"

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local diff = {
	"diff",
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	diff_color = {
		added = { fg = green },
		modified = { fg = yellow },
		removed = { fg = red },
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

		local supported_formatters = list_registered_null_ls_providers(buf_ft, null_ls.methods.FORMATTING)
		vim.list_extend(buf_client_names, supported_formatters)

		local supported_linters = list_registered_null_ls_providers(buf_ft, null_ls.methods.DIAGNOSTICS)
		vim.list_extend(buf_client_names, supported_linters)

		return "[" .. table.concat(buf_client_names, ", ") .. "]"
	end,
	icon = " LSP:",
	color = { gui = "bold" },
	cond = hide_in_width,
}

local function python_env_cleanup(venv)
	if string.find(venv, "/") then
		local final_venv = venv
		for w in venv:gmatch("([^/]+)") do
			final_venv = w
		end
		venv = final_venv
	end
	return venv
end

local python_env = {
	function()
		if vim.bo.filetype == "python" then
			local venv = os.getenv("CONDA_DEFAULT_ENV")
			if venv then
				return string.format("  (%s)", python_env_cleanup(venv))
			end
			venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return string.format("  (%s)", python_env_cleanup(venv))
			end
			return ""
		end
		return ""
	end,
	color = { fg = green },
	cond = hide_in_width,
}

local treesitter = {
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return ""
		end
		return ""
	end,
	color = { fg = green },
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
		lualine_c = { diff, python_env, filename, diagnostics },
		lualine_x = { lsp, spaces, encoding, fileformat, treesitter, filetype },
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
})
