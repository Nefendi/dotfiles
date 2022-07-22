local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<m-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	-- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "tab",
	on_open = function(_)
		vim.cmd("startinsert!")
		vim.cmd("set laststatus=0")
	end,
	on_close = function(_)
		vim.cmd("set laststatus=3")
	end,
	count = 99,
})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local opts = { silent = true }

local keymap = vim.keymap.set

keymap("n", "<m-1>", "<cmd>1ToggleTerm direction=float<cr>", opts)
keymap("t", "<m-1>", "<cmd>1ToggleTerm direction=float<cr>", opts)
keymap("i", "<m-1>", "<cmd>1ToggleTerm direction=float<cr>", opts)

keymap("n", "<m-2>", "<cmd>2ToggleTerm direction=float<cr>", opts)
keymap("t", "<m-2>", "<cmd>2ToggleTerm direction=float<cr>", opts)
keymap("i", "<m-2>", "<cmd>2ToggleTerm direction=float<cr>", opts)

keymap("n", "<m-3>", "<cmd>3ToggleTerm direction=float<cr>", opts)
keymap("t", "<m-3>", "<cmd>3ToggleTerm direction=float<cr>", opts)
keymap("i", "<m-3>", "<cmd>3ToggleTerm direction=float<cr>", opts)

keymap("n", "<m-4>", "<cmd>4ToggleTerm direction=float<cr>", opts)
keymap("t", "<m-4>", "<cmd>4ToggleTerm direction=float<cr>", opts)
keymap("i", "<m-4>", "<cmd>4ToggleTerm direction=float<cr>", opts)

-- keymap("n", "<m-2>", "<cmd>3ToggleTerm size=20 direction=horizontal | set cmdheight=1<cr>", opts)
-- keymap("t", "<m-2>", "<cmd>3ToggleTerm size=20 direction=horizontal | set cmdheight=1<cr>", opts)
-- keymap("i", "<m-2>", "<cmd>3ToggleTerm size=20 direction=horizontal | set cmdheight=1<cr>", opts)

-- keymap("n", "<m-3>", "<cmd>2ToggleTerm size=80 direction=vertical<cr>", opts)
-- keymap("t", "<m-3>", "<cmd>2ToggleTerm size=80 direction=vertical<cr>", opts)
-- keymap("i", "<m-3>", "<cmd>2ToggleTerm size=80 direction=vertical<cr>", opts)
