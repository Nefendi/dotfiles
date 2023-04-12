local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup {
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
}

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "none",
        width = 100000,
        height = 100000,
    },
    on_open = function(_)
        vim.cmd "startinsert!"
        -- FIXME: A not so nice workaround for removing the last line of visible
        -- text under the terminal with Lazygit. This is probably caused by noice.nvim
        -- hijacking cmdheight and setting it to 0.
        vim.cmd ":Noice disable"
        vim.cmd "set laststatus=0"
        vim.cmd "set cmdheight=1"
    end,
    on_close = function(_)
        vim.cmd ":Noice enable"
        vim.cmd "set laststatus=3"
    end,
    count = 99,
}

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local opts = { silent = true, noremap = true }

local keymap = vim.keymap.set

-- local vertical_term = Terminal:new {
--     direction = "vertical",
--     on_open = function(term)
--         vim.cmd "startinsert!"
--         vim.api.nvim_buf_set_keymap(
--             term.bufnr,
--             "n",
--             "<m-v>",
--             "<cmd>2ToggleTerm size=80 direction=vertical<cr>",
--             { noremap = true, silent = true }
--         )
--         vim.api.nvim_buf_set_keymap(
--             term.bufnr,
--             "t",
--             "<m-v>",
--             "<cmd>2ToggleTerm size=80 direction=vertical<cr>",
--             { noremap = true, silent = true }
--         )
--         vim.api.nvim_buf_set_keymap(
--             term.bufnr,
--             "i",
--             "<m-v>",
--             "<cmd>2ToggleTerm size=80 direction=vertical<cr>",
--             { noremap = true, silent = true }
--         )
--         vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-1>", "<nop>", { noremap = true, silent = true })
--         vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-2>", "<nop>", { noremap = true, silent = true })
--         vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-3>", "<nop>", { noremap = true, silent = true })
--         vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-4>", "<nop>", { noremap = true, silent = true })
--     end,
--     count = 5,
-- }

-- function _VERTICAL_TERM()
--     vertical_term:toggle(80)
-- end

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

keymap("n", "<m-v>", "<cmd>5ToggleTerm direction=vertical size=80<cr>", opts)
keymap("t", "<m-v>", "<cmd>5ToggleTerm direction=vertical size=80<cr>", opts)
keymap("i", "<m-v>", "<cmd>5ToggleTerm direction=vertical size=80<cr>", opts)

-- keymap("n", "<m-v>", "<cmd>lua _VERTICAL_TERM()<cr>", opts)
-- keymap("t", "<m-v>", "<cmd>lua _VERTICAL_TERM()<cr>", opts)
-- keymap("i", "<m-v>", "<cmd>lua _VERTICAL_TERM()<cr>", opts)
