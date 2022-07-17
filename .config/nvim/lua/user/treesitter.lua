local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "markdown" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
		disable = { "markdown" },
	},
	indent = { enable = true, disable = { "python", "css", "markdown" } },
	context_commentstring = { enable = true, disable = { "markdown" } },
	rainbow = {
		enable = true,
		extended_mode = false,
		max_file_lines = nil,
		colors = {
			-- "#bf616a",
			-- "#d08770",
			-- "#ebcb8b",
			-- "#a3be8c",
			-- "#88c0d0",
			-- "#5e81ac",
			-- "#b48ead",
			"#68a0b0",
			"#946EaD",
			"#c7aA6D",
		},
		disable = { "html" },
	},
	playground = { enable = true },
})
