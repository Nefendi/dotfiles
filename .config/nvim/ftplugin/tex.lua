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
        name = "LaTeX",
        v = { "<cmd>TexlabForward<cr>", "View PDF/Forward Search" },
        b = { "<cmd>TexlabBuild<cr>", "Build" },
        d = { "<cmd>VimtexDocPackage<cr>", "Show Package Documentation" },
        t = { "<cmd>VimtexTocToggle<cr>", "Toggle TOC" },
        c = { "<cmd>VimtexClean<cr>", "Clean" },
        C = { "<cmd>VimtexClean!<cr>", "Clean with Output Files" },
        w = { "<cmd>VimtexCountWords!<cr>", "Count Words" },
        l = { "<cmd>VimtexCountLetters!<cr>", "Count Letters" },
    },
}

which_key.register(mappings, opts)
