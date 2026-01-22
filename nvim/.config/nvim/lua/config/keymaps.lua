local M = {}

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Splits
-- keymap("n", "<m-s>", "<cmd>split<cr>", opts)
-- keymap("n", "<m-v>", "<cmd>vsplit<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move lines
-- keymap("n", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close
-- keymap("n", "<leader>c", "<cmd>Bdelete!<CR>", opts)
-- keymap("n", "<leader>q", "<C-w>q", opts)
keymap("n", "<m-q>", "<cmd>:q<cr>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Save
-- keymap("n", "<leader>w", ":w<CR>", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Open with a system application
keymap("n", "gx", [[:silent execute '!xdg-open ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)

-- Plugins --

-- Noice
keymap({ "n", "i", "s" }, "<c-d>", function()
    if not require("noice.lsp").scroll(4) then
        return "<c-d>"
    end
end, { silent = true, expr = true })

keymap({ "n", "i", "s" }, "<c-u>", function()
    if not require("noice.lsp").scroll(-4) then
        return "<c-u>"
    end
end, { silent = true, expr = true })

-- JABS
-- keymap("n", "<m-b>", "<cmd>JABSOpen<cr>", opts)

-- Jaq
keymap("n", "<m-r>", ":silent only | Jaq<cr>", opts)

-- Git
-- keymap("n", "<leader>gb", ":GitBlameToggle<CR>", opts)

-- Glow
-- keymap("n", "<leader>mg", ":Glow<CR>", opts)

-- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Formatting
-- keymap("n", "<leader>F", "<cmd>LspToggleAutoFormat<cr>", opts)

keymap({ "n", "x", "o" }, "<c-space>", function()
    require("flash").treesitter {
        actions = {
            ["<c-space>"] = "next",
            ["<BS>"] = "prev",
        },
    }
end, { desc = "Treesitter incremental selection" })

return M
