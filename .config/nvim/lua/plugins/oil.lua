function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        keys = {
            {
                "<leader>e",
                "<CMD>Oil<CR>",
                desc = "Open Parent Directory",
            },
            {
                "<leader>E",
                "<CMD>Oil " .. vim.uv.cwd() .. "<CR>",
                desc = "Open Current Working Directory",
            },
        },
        opts = {
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()",
            },
            view_options = {
                show_hidden = true,
            },
            use_default_keymaps = true,
            keymaps = {
                ["L"] = "actions.select",
                ["H"] = { "actions.parent", mode = "n" },
                ["<leader>p"] = "actions.preview",
                ["<leader>c"] = { "actions.close", mode = "n" },
                ["<leader>e"] = { "actions.close", mode = "n" },
                ["<leader>r"] = "actions.refresh",
                ["gy"] = { "actions.yank_entry", opts = { modify = ":." }, desc = "Yank relative path", mode = "n" },
                ["gY"] = { "actions.yank_entry", desc = "Yank absolute path", mode = "n" },
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail

                        if detail then
                            require("oil").set_columns { "icon", "permissions", "size", "mtime" }
                        else
                            require("oil").set_columns { "icon" }
                        end
                    end,
                },
            },
        },
    },
}
