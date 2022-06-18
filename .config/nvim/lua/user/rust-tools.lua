local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
	return
end

local lsp_installer_servers_status_ok, lsp_installer_servers = pcall(require, "nvim-lsp-installer.servers")
if not lsp_installer_servers_status_ok then
	return
end

local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")

rust_tools.setup({
	tools = {
		autoSetHints = true,
		hover_with_actions = true,
	},
	server = {
		cmd_env = requested_server._default_options.cmd_env,
		-- on_attach = require("lvim.lsp").common_on_attach,
		-- on_init = require("lvim.lsp").common_on_init,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					enable = true,
					command = "clippy",
					allFeatures = true,
					extraArgs = {
						"--target-dir",
						"/tmp/rust-analyzer-check",
					},
				},
			},
		},
	},
})
