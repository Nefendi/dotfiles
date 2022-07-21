local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

local icons = require("user.icons")

dashboard.section.header.val = {
	[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
	[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
	[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
	[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
	[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
	[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}

dashboard.section.buttons.val = {
	dashboard.button("f", icons.documents.Files .. "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", icons.documents.File .. "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button(
		"p",
		icons.git.Repo .. "  Find project",
		":lua require('telescope').extensions.projects.projects()<CR>"
	),
	dashboard.button("r", icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", icons.ui.List .. "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", icons.ui.Cog .. "  Config", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", icons.ui.Leave .. "  Quit", ":qa<CR>"),
}

local function footer()
	-- NOTE: requires the fortune-mod package to work
	local handle = io.popen("fortune")
	if not handle then
		return "No fortune cookies for you :("
	end
	local fortune = handle:read("*a")
	handle:close()
	return fortune
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Constant"
dashboard.section.header.opts.hl = "Macro"
dashboard.section.buttons.opts.hl = "Macro"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
