local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

local icons = require("user.icons")

telescope.setup({
	defaults = {
		prompt_prefix = icons.ui.Telescope .. " ",
		selection_caret = icons.ui.EnterArrow .. " ",
		path_display = { "smart" },
		-- Some directories, e.g. Haskell's .stack-work are not ignored in when put into this array. To mitigate that
		-- issue put the directory directly in the command line options of a search programme
		file_ignore_patterns = {
			-- General
			".git/",
			".idea/",
			".vscode/",

			-- JavaScript
			"node_modules/",

			-- Python
			".venv/",
			".mypy_cache/",
			".pytest_cache/",
			"__pycache__",

			-- Rust
			"target/",
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"-uu",
			"--glob",
			-- Haskell
			"!.stack-work/",
		},
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = {
				"rg",
				"--files",
				"-uu",
				"--glob",
				-- Haskell
				"!.stack-work/",
			},
		},
		live_grep = {
			only_sort_text = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg",
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("notify")
telescope.load_extension("fzf")
telescope.load_extension("media_files")
