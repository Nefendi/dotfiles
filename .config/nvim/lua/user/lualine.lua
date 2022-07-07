-- Sources: https://github.com/LunarVim/LunarVim and https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/lualine.lua

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local status_theme_ok, theme = pcall(require, "lualine.themes.onedarker_alt")
if not status_theme_ok then
	return
end

local icons = require("user.icons")

local functions = require("user.functions")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 70
end

local green = "#98BE65"
local yellow = "#ECBE7B"
local red = "#EC5F67"

-- darkplus
-- vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = false })
-- vim.api.nvim_set_hl(0, "SLLocation", { fg = "#D4D4D4", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "#252525" })

-- onedarker
vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = "#32363e", bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#abb2bf", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = "#282c34" })

local mode_color = {
	-- darkplus
	-- n = "#569cd6",
	-- i = "#6a9955",
	-- v = "#c586c0",
	-- [""] = "#c586c0",
	-- V = "#c586c0",
	-- c = "#4EC9B0",
	-- no = "#569cd6",
	-- s = "#ce9178",
	-- S = "#ce9178",
	-- [""] = "#ce9178",
	-- ic = "#dcdcaa",
	-- R = "#d16969",
	-- Rv = "#d16969",
	-- cv = "#569cd6",
	-- ce = "#569cd6",
	-- r = "#d16969",
	-- rm = "#4EC9B0",
	-- ["r?"] = "#4EC9B0",
	-- ["!"] = "#4EC9B0",
	-- t = "#D7BA7D",

	-- onedarker
	n = "#61afef",
	i = "#e06c75",
	v = "#c678dd",
	[""] = "#c678dd",
	V = "#c678dd",
	c = "#56b6c2",
	no = "#61afef",
	s = "#d19a66",
	S = "#d19a66",
	[""] = "#d19a66",
	ic = "#e06c75",
	R = "#d19a66",
	Rv = "#e06c75",
	cv = "#61afef",
	ce = "#61afef",
	r = "#e06c75",
	rm = "#56b6c2",
	["r?"] = "#56b6c2",
	["!"] = "#56b6c2",
	t = "#98c379",
}

local mode = {
	function()
		return " "
	end,
	color = function()
		return { bg = mode_color[vim.fn.mode()] }
	end,
	padding = 0,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = {
		error = icons.diagnostics_codicons.Error .. " ",
		warn = icons.diagnostics_codicons.Warning .. " ",
		info = icons.diagnostics_codicons.Info .. " ",
		hint = icons.diagnostics_codicons.Hint .. " ",
	},
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	symbols = {
		added = icons.git.Added .. " ",
		modified = icons.git.Modified .. " ",
		removed = icons.git.Removed .. " ",
	}, -- changes diff symbols
	diff_color = {
		added = { fg = green },
		modified = { fg = yellow },
		removed = { fg = red },
	},
	cond = hide_in_width,
	separator = "%#SLSeparator# " .. icons.misc.ThinBar .. "%*",
}

local filetype = {
	"filetype",
	icons_enabled = true,
	cond = hide_in_width,
}

local filename = {
	"filename",
	color = {},
	cond = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "%#SLGitIcon#" .. icons.git.Branch .. "%*" .. "%#SLBranchName#",
	colored = false,
}

local spaces = {
	function()
		if not vim.api.nvim_buf_get_option(0, "expandtab") then
			return "tab size: " .. vim.api.nvim_buf_get_option(0, "tabstop")
		end
		local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
		if size == 0 then
			size = vim.api.nvim_buf_get_option(0, "tabstop")
		end
		return "spaces: " .. size
	end,
	cond = hide_in_width,
	-- separator = "%#SLSeparator#" .. icons.misc.RightThinBar .. "%*",
}

local fileformat = {
	"fileformat",
	icons_enabled = false,
	separator = "%#SLSeparator#" .. icons.misc.RightThinBar .. " %*",
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

		local supported_formatters = functions.list_registered_null_ls_providers(buf_ft, null_ls.methods.FORMATTING)
		vim.list_extend(buf_client_names, supported_formatters)

		local supported_linters = functions.list_registered_null_ls_providers(buf_ft, null_ls.methods.DIAGNOSTICS)
		vim.list_extend(buf_client_names, supported_linters)

		return "[" .. table.concat(buf_client_names, ", ") .. "]"
	end,
	-- icon = icons.ui.Cogs .. "LSP:",
	color = { gui = "bold" },
	padding = 0,
	cond = hide_in_width,
	separator = "%#SLSeparator# " .. icons.misc.RightThinBar .. "%* ",
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
				return string.format(" %s (%s)", icons.misc.Python, python_env_cleanup(venv))
			end
			venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return string.format(" %s (%s)", icons.misc.Python, python_env_cleanup(venv))
			end
			return ""
		end
		return ""
	end,
	color = { fg = green },
	cond = hide_in_width,
}

local current_signature = {
	function()
		if not pcall(require, "lsp_signature") then
			return
		end
		local sig = require("lsp_signature").status_line(30)
		return "%#SLSeparator#" .. sig.hint .. "%*"
	end,
	cond = hide_in_width,
}

local treesitter = {
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return icons.misc.Tree
		end
		return ""
	end,
	color = { fg = green },
	cond = hide_in_width,
}

local location = {
	"location",
	color = "SLLocation",
	separator = { left = " " },
}

local progress = {
	"progress",
	color = function()
		-- darkplus
		-- return { fg = "#252525", bg = mode_color[vim.fn.mode()] }
		-- onedarker
		return { fg = "#1E232A", bg = mode_color[vim.fn.mode()] }
	end,
}

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode, branch },
		lualine_b = { diagnostics },
		lualine_c = { python_env, current_signature },
		lualine_x = { lsp, diff, spaces, encoding, fileformat, filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
})
