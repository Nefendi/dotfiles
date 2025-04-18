local which_key = require "which-key"

local mappings = {
    { "<leader>L", group = "Markdown", nowait = true, remap = false },
    { "<leader>Lg", "<cmd>Glow<cr>", desc = "Glow Preview", nowait = true, remap = false },
    { "<leader>Lp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Browser Preview", nowait = true, remap = false },
    { "<leader>Lr", "<cmd>RenderMarkdown toggle<cr>", desc = "Render Markdown", nowait = true, remap = false },
}

which_key.add(mappings)

vim.opt.textwidth = 80

-- vim.cmd([[setlocal conceallevel=2]])
