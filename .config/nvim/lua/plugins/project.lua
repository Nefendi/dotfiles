return {
    {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        config = function()
            local project = require "project_nvim"

            project.setup {

                -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
                detection_methods = { "pattern" },

                -- patterns used to detect root dir, when **"pattern"** is in detection_methods
                patterns = {
                    ".git",
                    "_darcs",
                    ".hg",
                    ".bzr",
                    ".svn",
                    "package.json",
                    "go.mod",
                    "Cargo.toml",
                    "stack.yaml",
                    "mix.exs",
                    -- Custom marker file
                    ".project.nvim",
                },
            }
        end,
    },
}
