lvim.format_on_save.timeout = 5000

vim.opt.background = "dark"
vim.opt.relativenumber = true
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120
vim.opt.linebreak = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

lvim.colorscheme = "kanagawa"

local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_x = {
	components.treesitter,
	components.lsp,
	components.filetype,
	components.encoding,
	components.spaces,
}

lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.terminal.size = 30

lvim.lsp.diagnostics.virtual_text = true

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- nvim-tree
lvim.builtin.nvimtree.setup.view.width = 50

-- project.nvim
vim.list_extend(lvim.builtin.project.patterns, { "go.mod", "Cargo.toml" })

-- Telescope
local telescope = lvim.builtin.telescope
local actions = require("telescope.actions")

telescope.defaults.mappings.i = {
	["<C-n>"] = actions.cycle_history_next,
	["<C-p>"] = actions.cycle_history_prev,

	["<C-j>"] = actions.move_selection_next,
	["<C-k>"] = actions.move_selection_previous,
}

telescope.defaults.vimgrep_arguments = {
	"rg",
	"--hidden",
	"--color=never",
	"--no-heading",
	"--with-filename",
	"--line-number",
	"--column",
	"--smart-case",
	"-g",
	"!.git",
	"-g",
	"!node_modules",
}

telescope.defaults.pickers.find_files.find_command = {
	"rg",
	"--files",
	"--hidden",
	"-g",
	"!.git",
	"-g",
	"!node_modules",
}
telescope.defaults.pickers.live_grep.vimgrep_arguments = {
	"rg",
	"--hidden",
	"--color=never",
	"--no-heading",
	"--with-filename",
	"--line-number",
	"--column",
	"--smart-case",
	"-g",
	"!.git",
	"-g",
	"!node_modules",
}

require("telescope").setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "-g", "!.git", "-g", "!node_modules" },
		},
		live_grep = {
			vimgrep_arguments = {
				"rg",
				"--hidden",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"-g",
				"!.git",
				"-g",
				"!node_modules",
			},
		},
	},
})

require("telescope").load_extension("media_files")

telescope.extensions.media_files = {
	-- filetypes whitelist
	-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
	filetypes = { "png", "webp", "jpg", "jpeg" },
	find_cmd = "rg", -- find command (defaults to `fd`)
}

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["G"] = {
	name = "+Go",
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
}
lvim.builtin.which_key.mappings["a"] = { "<cmd>:wa<cr>", "Save All" }
lvim.builtin.which_key.mappings["m"] = {
	name = "+Markdown",
	p = { "<cmd>:Glow<cr>", "Preview" },
}
lvim.builtin.which_key.mappings["s"] = vim.tbl_extend("force", {
	s = { "<cmd>Telescope grep_string<CR>", "Grep string" },
	m = { "<cmd>Telescope media_files<CR>", "Search media files" },
}, lvim.builtin.which_key.mappings["s"])

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.treesitter.ensure_installed = "all"

lvim.builtin.treesitter.highlight.enabled = true

-- ls_emmet support
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local ls_emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
ls_emmet_capabilities.textDocument.completion.completionItem.snippetSupport = true

if not configs.ls_emmet then
	configs.ls_emmet = {
		default_config = {
			cmd = { "ls_emmet", "--stdio" },
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"haml",
				"xml",
				"xsl",
				"pug",
				"slim",
				"sass",
				"stylus",
				"less",
				"sss",
			},
			root_dir = function(fname)
				return vim.loop.cwd()
			end,
			settings = {},
		},
	}
end

lspconfig.ls_emmet.setup({ capabilities = ls_emmet_capabilities })

local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
	{
		exe = "black",
	},
	{
		exe = "isort",
	},
	{
		exe = "prettier",
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"html",
			"css",
			"scss",
		},
	},
	{
		exe = "stylua",
	},
	{
		exe = "golines",
	},
	{
		exe = "gofumpt",
	},
})

local linters = require("lvim.lsp.null-ls.linters")

linters.setup({
	{
		exe = "flake8",
	},
	{
		exe = "pylint",
	},
	{
		exe = "mypy",
	},
	{
		exe = "shellcheck",
		args = { "--severity", "warning" },
	},
	{
		exe = "eslint_d",
	},
	{
		exe = "golangci-lint",
	},
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- Additional Plugins
lvim.plugins = {
	{
		"fatih/vim-go",
		run = function()
			vim.cmd(":GoUpdateBinaries")
		end,
		config = function()
			vim.g.go_def_mapping_enabled = 0
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local lsp_installer_servers = require("nvim-lsp-installer.servers")
			local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					cmd_env = requested_server._default_options.cmd_env,
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								enable = true,
								command = "clippy",
								extraArgs = {
									"--target-dir",
									"/tmp/rust-analyzer-check",
								},
							},
						},
					},
				},
			})
		end,
		ft = { "rust", "rs" },
	},
	{
		"Saecki/crates.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"David-Kunz/cmp-npm",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("cmp-npm").setup()

			table.insert(lvim.builtin.cmp.sources, { name = "npm", keyword_length = 4 })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char_list = { "|", "¦", "┆", "┊" }
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "alpha" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach()
		end,
		event = "BufRead",
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{
		"ellisonleao/glow.nvim",
	},
	{
		"p00f/nvim-ts-rainbow",
		config = function()
			require("nvim-treesitter.configs").setup({
				rainbow = {
					enable = true,
					extended_mode = false,
					max_file_lines = nil,
					colors = {
						"#bf616a",
						"#d08770",
						"#ebcb8b",
						"#a3be8c",
						"#88c0d0",
						"#5e81ac",
						"#b48ead",
					},
				},
			})
		end,
	},
	{
		"folke/lsp-colors.nvim",
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
	},
	{
		"tpope/vim-surround",
	},
	{
		"tpope/vim-repeat",
	},
	{
		"lervag/vimtex",
	},
	{
		"rebelot/kanagawa.nvim",
	},
}
