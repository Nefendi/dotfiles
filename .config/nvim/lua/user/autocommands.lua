-- Use 'q' and '<esc>' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "qf",
        "help",
        "man",
        "lspinfo",
        "spectre_panel",
        "lir",
        "DressingSelect",
        "null-ls-info",
        "tsplayground",
    },
    callback = function()
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted 
    ]]
    end,
})

-- No numbers in lir
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "lir" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

-- Set rounded border
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "lspinfo",
        "null-ls-info",
        "help",
    },
    callback = function()
        vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), { border = "rounded" })
    end,
})

-- For some reason the 'gl' keymap does not work out of the box in certain filetypes.
-- Probably it is some stupid mistake somewhere but this circumvents the issue.
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "conf" },
    callback = function()
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "gl",
            "<cmd>lua vim.diagnostic.open_float()<CR>",
            { noremap = true, silent = true }
        )
    end,
})

-- This does not work
-- Set winblend
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = {
-- 		"lspinfo",
-- 		"lsp-installer",
-- 		"null-ls-info",
-- 	},
-- 	callback = function()
-- 		vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), { winblend = 0 })
-- 	end,
-- })

-- Use 'q' to quit in non-buffer types
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "" },
    callback = function()
        local buf_ft = vim.bo.filetype
        if buf_ft == "" or buf_ft == nil then
            vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      " nnoremap <silent> <buffer> <c-j> j<CR> 
      " nnoremap <silent> <buffer> <c-k> k<CR> 
      set nobuflisted 
    ]]
        end
    end,
})

-- Always start terminals in insert mode
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "term://*" },
    callback = function()
        vim.cmd "startinsert!"
    end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end,
})

-- Set wrap in markdown and gitcommit
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "gitcommit", "markdown" },
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 	end,
-- })

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end,
})

-- Check for buffers changed outside of vim upon entering a buffer
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd "checktime"
    end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
})

-- LuaSnip
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
        local status_ok, luasnip = pcall(require, "luasnip")
        if not status_ok then
            return
        end
        if luasnip.expand_or_jumpable() then
            vim.cmd [[silent! lua require("luasnip").unlink_current()]]
        end
    end,
})
