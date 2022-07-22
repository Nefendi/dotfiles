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
		name = "Go",
		b = { "<cmd>GoBuild<cr>", "Build" },
		r = { "<cmd>GoRun<cr>", "Run" },
		t = { "<cmd>GoTest<cr>", "Test" },
		c = { "<cmd>GoCoverageToggle<cr>", "Toggle coverage" },
		g = { "<cmd>GoGenerate<cr>", "Generate" },
		i = { "<cmd>GoImpl<cr>", "Implement" },
		T = { "<cmd>GoAddTags<cr>", "Add tags" },
		R = { "<cmd>GoRemoveTags<cr>", "Remove tags" },
		e = { "<cmd>GoIfErr<cr>", "Add if-err statement" },
		f = { "<cmd>GoFillStruct<cr>", "Fill struct" },
	},
}

which_key.register(mappings, opts)
