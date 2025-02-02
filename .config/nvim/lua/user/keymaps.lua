local M = {}

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

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
keymap("n", "<A-j>", ":MoveLine(1)<CR>", opts)
keymap("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
-- keymap("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
-- keymap("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
-- keymap("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
-- keymap("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)

keymap("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
keymap("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
keymap("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)

-- keymap("n", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

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

M.show_documentation = function()
    local filetype = vim.bo.filetype

    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
    elseif vim.fn.expand "%:t" == "Cargo.toml" then
        require("crates").show_popup()
    else
        local winid = require("ufo").peekFoldedLinesUnderCursor()

        if not winid then
            vim.lsp.buf.hover()
        end
    end
end

keymap("n", "K", ":lua require('user.keymaps').show_documentation()<CR>", opts)

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

-- Cybu
keymap("n", "<a-S-h>", "<Plug>(CybuPrev)")
keymap("n", "<a-S-l>", "<Plug>(CybuNext)")
keymap("n", "<s-h>", "<Plug>(CybuLastusedPrev)")
keymap("n", "<s-l>", "<Plug>(CybuLastusedNext)")

-- JABS
-- keymap("n", "<m-b>", "<cmd>JABSOpen<cr>", opts)

-- Jaq
keymap("n", "<m-r>", ":silent only | Jaq<cr>", opts)

-- Lir
keymap("n", "-", ":lua require'lir.float'.toggle()<cr>", opts)

-- NvimTree
-- keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
-- keymap("n", "<m-g>", ":Telescope git_branches<CR>", opts)
-- keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>fT", ":Telescope grep_string<CR>", opts)
-- keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
-- keymap("n", "<leader>fd", ":Telescope diagnostics bufnr=0<CR>", opts)
-- keymap("n", "<leader>fD", ":Telescope diagnostics<CR>", opts)
-- keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
-- keymap("n", "<leader>fS", ":Telescope lsp_dynamic_workspace_symbols<CR>", opts)
-- keymap("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)
-- keymap("n", "<leader>fR", ":Telescope registers<CR>", opts)
-- keymap("n", "<leader>fn", ":Telescope notify<CR>", opts)

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
-- keymap("n", "<leader>gb", ":GitBlameToggle<CR>", opts)

-- Glow
-- keymap("n", "<leader>mg", ":Glow<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

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

return M
