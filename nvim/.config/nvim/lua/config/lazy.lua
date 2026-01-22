local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})

        vim.fn.getchar()

        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    spec = {
        { import = "plugins" },
        {
            "altermo/ultimate-autopair.nvim",
            event = { "InsertEnter", "CmdlineEnter" },
            branch = "v0.6", --recommended as each new version will have breaking changes
            opts = {
                tabout = {
                    enable = true,
                },
                cmap = false,
                extensions = {
                    filetype = {
                        nft = { "snacks_picker_input" },
                    },
                },
            },
        },
        {
            "nvim-tree/nvim-web-devicons",
            opts = {
                override_by_extension = {
                    ["exs"] = {
                        icon = "",
                        color = "#a074c4",
                        cterm_color = "140",
                        name = "Exs",
                    },
                },
            },
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = function()
                vim.fn["mkdp#util#install"]()
            end,
            ft = "markdown",
        },
        { "kevinhwang91/nvim-bqf", ft = "qf" },
        { "b0o/schemastore.nvim" },
        { "fladson/vim-kitty", ft = "kitty" },
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim", build = ":MasonUpdate" },
        { "williamboman/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        { "nvimtools/none-ls.nvim" },
        { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
        {
            "mrcjkb/rustaceanvim",
            version = "^6",
            lazy = false,
        },
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        { "mfussenegger/nvim-jdtls" },
        {
            "mfussenegger/nvim-ansible",
            event = "VimEnter",
        },
    },
    ui = {
        border = "rounded",
    },
    checker = {
        enabled = false,
    },
    rocks = { hererocks = true },
}
