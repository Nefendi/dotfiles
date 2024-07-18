vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "Cargo.toml" },
    callback = function()
        local status_ok, which_key = pcall(require, "which-key")
        if not status_ok then
            return
        end

        local mappings = {
            { "<leader>L", group = "Cargo", nowait = true, remap = false },
            {
                "<leader>LA",
                "<cmd>lua require('crates').upgrade_all_crates()<CR>",
                desc = "Upgrade All",
                nowait = true,
                remap = false,
            },
            {
                "<leader>LD",
                "<cmd>lua require('crates').show_dependencies_popup()<CR>",
                desc = "Dependencies",
                nowait = true,
                remap = false,
            },
            {
                "<leader>LU",
                "<cmd>lua require('crates').upgrade_crate()<CR>",
                desc = "Upgrade",
                nowait = true,
                remap = false,
            },
            {
                "<leader>La",
                "<cmd>lua require('crates').update_all_crates()<CR>",
                desc = "Update All",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Lc",
                "<cmd>lua require('crates').open_crates_io()<CR>",
                desc = "Open Crates.io",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Ld",
                "<cmd>lua require('crates').open_documentation()<CR>",
                desc = "Open Doc",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Lf",
                "<cmd>lua require('crates').show_features_popup()<CR>",
                desc = "Features",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Lh",
                "<cmd>lua require('crates').open_homepage()<CR>",
                desc = "Open Home",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Li",
                "<cmd>lua require('crates').show_popup()<CR>",
                desc = "Info",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Lr",
                "<cmd>lua require('crates').open_repository()<CR>",
                desc = "Open Repo",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Lt",
                "<cmd>lua require('crates').toggle()<CR>",
                desc = "Toggle Hints",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Lu",
                "<cmd>lua require('crates').update_crate()<CR>",
                desc = "Update",
                nowait = true,
                remap = false,
            },
            {
                "<leader>Lv",
                "<cmd>lua require('crates').show_versions_popup()<CR>",
                desc = "Versions",
                nowait = true,
                remap = false,
            },
        }

        which_key.add(mappings)
    end,
})
