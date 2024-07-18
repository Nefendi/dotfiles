local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local mappings = {
    { "<leader>L", group = "LaTeX", nowait = true, remap = false },
    { "<leader>LC", "<cmd>VimtexClean!<cr>", desc = "Clean with Output Files", nowait = true, remap = false },
    { "<leader>Lb", "<cmd>TexlabBuild<cr>", desc = "Build", nowait = true, remap = false },
    { "<leader>Lc", "<cmd>VimtexClean<cr>", desc = "Clean", nowait = true, remap = false },
    { "<leader>Ld", "<cmd>VimtexDocPackage<cr>", desc = "Show Package Documentation", nowait = true, remap = false },
    { "<leader>Ll", "<cmd>VimtexCountLetters!<cr>", desc = "Count Letters", nowait = true, remap = false },
    { "<leader>Lt", "<cmd>VimtexTocToggle<cr>", desc = "Toggle TOC", nowait = true, remap = false },
    { "<leader>Lv", "<cmd>TexlabForward<cr>", desc = "View PDF/Forward Search", nowait = true, remap = false },
    { "<leader>Lw", "<cmd>VimtexCountWords!<cr>", desc = "Count Words", nowait = true, remap = false },
}

which_key.add(mappings)
