local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup({
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
    { "numToStr/Comment.nvim" },
    { "kyazdani42/nvim-tree.lua" },
    { "nvim-tree/nvim-web-devicons" },
    { "moll/vim-bbye" },
    { "nvim-lualine/lualine.nvim" },
    { "akinsho/toggleterm.nvim", version = "v2.*" },
    { "ahmedkhalf/project.nvim", event = "VimEnter" },
    { "lukas-reineke/indent-blankline.nvim" },
    { "goolord/alpha-nvim" },
    { "kylechui/nvim-surround" },
    { "tpope/vim-repeat" },
    { "lervag/vimtex" },
    { "folke/todo-comments.nvim" },
    { "ggandor/leap.nvim" },
    { "ggandor/flit.nvim" },
    { "NvChad/nvim-colorizer.lua" },
    { "nacro90/numb.nvim" },
    { "ellisonleao/glow.nvim" },
    { "rcarriga/nvim-notify" },
    { "folke/which-key.nvim", event = "VeryLazy" },
    { "nvim-pack/nvim-spectre" },
    { "stevearc/dressing.nvim" },
    { "abecodes/tabout.nvim" },
    { "ghillb/cybu.nvim" },
    { "karb94/neoscroll.nvim" },
    { "is0n/jaq-nvim" },
    {
        "iamcco/markdown-preview.nvim",
        commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
        build = "cd app && npm install",
        ft = "markdown",
    },
    { "kevinhwang91/nvim-bqf", ft = "qf" },
    { "junegunn/vim-slash" },
    { "LunarVim/peek.lua" },
    {
        "jiaoshijie/undotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        commit = "6cb7e65e03871d2567d2c44745d3de57d07ca1fd",
    },
    {
        "0x100101/lab.nvim",
        build = "cd js && npm ci",
        dependencies = { "nvim-lua/plenary.nvim" },
        commit = "733b4dd2c1b87013291c21d80afbe5255712d1d3",
    },
    { "tamago324/lir.nvim" },
    { "b0o/schemastore.nvim" },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        commit = "967b280d7d7ade52d97d06e868ec4d9a0bc59282",
    },
    { "monaqa/dial.nvim" },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        commit = "a0e19486ccc1fb134f6ef7bf914d07bbb462e346",
    },
    { "folke/neodev.nvim" },
    {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
        commit = "56b9ce31ec9d09d560fe8787c0920f76bc208297",
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    -- Colorschemes
    { "lunarvim/onedarker.nvim" },
    { "lunarvim/darkplus.nvim" },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "fladson/vim-kitty" },

    -- Cmp plugins
    { "hrsh7th/nvim-cmp" }, -- The completion plugin
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-emoji" },
    {
        "Saecki/crates.nvim",
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "David-Kunz/cmp-npm",
        commit = "4b6166c3feeaf8dae162e33ee319dc5880e44a29",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "tzachar/cmp-tabnine",
        commit = "a6cb553143573861d2d98da86ceb3074c87fc536",
        dependencies = { "hrsh7th/nvim-cmp" },
        build = "./install.sh",
    },

    -- Snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },

    -- LSP
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "RRethy/vim-illuminate" },
    { "folke/lsp-colors.nvim" },
    { "ray-x/lsp_signature.nvim" },
    { "smjonas/inc-rename.nvim" },
    {
        "SmiteshP/nvim-navic",
        commit = "7e9d2b2b601149fecdccd11b516acb721e571fe6",
        dependencies = { "neovim/nvim-lspconfig" },
    },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
    { "lvimuser/lsp-inlayhints.nvim" },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        commit = "b70c9ef0f8e2673a11387a39185ff249e00df19f",
    },
    {
        "luukvbaal/statuscol.nvim",
        commit = "49a3bdab3e9cf23982724c1e888a6296fca4c8b9",
    },

    -- Go
    { "olexsmir/gopher.nvim" },

    -- Rust
    {
        "simrat39/rust-tools.nvim",
        commit = "71d2cf67b5ed120a0e31b2c8adb210dd2834242f",
    },

    -- Lua
    {
        "folke/lua-dev.nvim",
        commit = "f5c31936fe06fcbeb59b98f69f74f9c2f91abaec",
    },

    -- Java
    { "mfussenegger/nvim-jdtls" },

    -- Telescope
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6",
        build = "make",
    },
    { "nvim-telescope/telescope-media-files.nvim" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "89e5fa66cf53854f45cfcfae45afb93171cf5c05",
        build = function()
            require("nvim-treesitter.install").update { with_sync = true }
        end,
    },
    -- { "p00f/nvim-ts-rainbow", lazy = false },
    { "mrjones2014/nvim-ts-rainbow", lazy = false },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "windwp/nvim-ts-autotag" },
    { "nvim-treesitter/playground" },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },

    -- Git
    { "lewis6991/gitsigns.nvim" },
    { "akinsho/git-conflict.nvim" },

    -- DAP
    { "mfussenegger/nvim-dap" },
    { "mfussenegger/nvim-dap-python" },
    { "leoluz/nvim-dap-go" },
    { "rcarriga/nvim-dap-ui" },

    -- nvim-test
    --  { "klen/nvim-test" },

    -- Neotest
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        },
        commit = "568feb5e9c7c5b7386886ecd4520389153aa7c7d",
    },
    { "rouge8/neotest-rust" },
    { "nvim-neotest/neotest-python" },
    { "nvim-neotest/neotest-go" },
    { "haydenmeade/neotest-jest" },
    { "marilari88/neotest-vitest" },
}, {
    ui = {
        border = "rounded",
    },
    defaults = {
        lazy = true,
    },
})
