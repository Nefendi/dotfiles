local which_key = require "which-key"

local mappings = {
    { "<leader>L", group = "LaTeX", nowait = true },
    -- { "<leader>LC", "<cmd>VimtexClean!<cr>", desc = "Clean with Output Files", nowait = true,  },
    -- { "<leader>Lc", "<cmd>VimtexClean<cr>", desc = "Clean", nowait = true,  },
    { "<leader>Lc", "<cmd>LspTexlabCleanArtifacts<cr>", desc = "Clean Artifacts", nowait = true },
    { "<leader>LC", "<cmd>LspTexlabCleanAuxiliary<cr>", desc = "Clean Auxiliary", nowait = true },
    { "<leader>Lb", "<cmd>LspTexlabBuild<cr>", desc = "Build", nowait = true },
    { "<leader>LB", "<cmd>LspTexlabCancelBuild<cr>", desc = "Cancel Build", nowait = true },
    -- { "<leader>Ld", "<cmd>VimtexDocPackage<cr>", desc = "Show Package Documentation", nowait = true,  },
    -- { "<leader>Ll", "<cmd>VimtexCountLetters!<cr>", desc = "Count Letters", nowait = true,  },
    -- { "<leader>Lt", "<cmd>VimtexTocToggle<cr>", desc = "Toggle TOC", nowait = true,  },
    { "<leader>Lv", "<cmd>LspTexlabForward<cr>", desc = "View PDF/Forward Search", nowait = true },
    -- { "<leader>Lw", "<cmd>VimtexCountWords!<cr>", desc = "Count Words", nowait = true,  },
}

which_key.add(mappings)
