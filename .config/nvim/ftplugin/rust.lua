local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	L = {
		name = "Rust",
		h = { "<cmd>RustToggleInlayHints<Cr>", "Toggle Inlay Hints" },
		r = { "<cmd>RustRunnables<Cr>", "Runnables" },
		e = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
		c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
		p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
		g = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
		w = { "<cmd>RustReloadWorkspace<Cr>", "Reload Workspace" },
	},
}

which_key.register(mappings, opts)
