vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "Cargo.toml" },
    callback = function()
        local which_key = require "which-key"

        local mappings = {
            { "<leader>L", group = "Cargo", nowait = true },
            {
                "<leader>LA",
                "<cmd>lua require('crates').upgrade_all_crates()<CR>",
                desc = "Upgrade All",
                nowait = true,
            },
            {
                "<leader>LD",
                "<cmd>lua require('crates').show_dependencies_popup()<CR>",
                desc = "Dependencies",
                nowait = true,
            },
            {
                "<leader>LU",
                "<cmd>lua require('crates').upgrade_crate()<CR>",
                desc = "Upgrade",
                nowait = true,
            },
            {
                "<leader>La",
                "<cmd>lua require('crates').update_all_crates()<CR>",
                desc = "Update All",
                nowait = true,
            },
            {
                "<leader>Lc",
                "<cmd>lua require('crates').open_crates_io()<CR>",
                desc = "Open Crates.io",
                nowait = true,
            },
            {
                "<leader>Ld",
                "<cmd>lua require('crates').open_documentation()<CR>",
                desc = "Open Doc",
                nowait = true,
            },
            {
                "<leader>Lf",
                "<cmd>lua require('crates').show_features_popup()<CR>",
                desc = "Features",
                nowait = true,
            },
            {
                "<leader>Lh",
                "<cmd>lua require('crates').open_homepage()<CR>",
                desc = "Open Home",
                nowait = true,
            },
            {
                "<leader>Li",
                "<cmd>lua require('crates').show_popup()<CR>",
                desc = "Info",
                nowait = true,
            },
            {
                "<leader>Lr",
                "<cmd>lua require('crates').open_repository()<CR>",
                desc = "Open Repo",
                nowait = true,
            },
            {
                "<leader>Lt",
                "<cmd>lua require('crates').toggle()<CR>",
                desc = "Toggle Hints",
                nowait = true,
            },
            {
                "<leader>Lu",
                "<cmd>lua require('crates').update_crate()<CR>",
                desc = "Update",
                nowait = true,
            },
            {
                "<leader>Lv",
                "<cmd>lua require('crates').show_versions_popup()<CR>",
                desc = "Versions",
                nowait = true,
            },
        }

        which_key.add(mappings)
    end,
})
