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
    { "nvim-lua/plenary.nvim", lazy = true, commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9" }, -- Useful lua functions used by lots of plugins
    { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }, -- Autopairs, integrates with both cmp and treesitter
    { "numToStr/Comment.nvim", commit = "350bf0cb47bfb2a48ddca79475888bc333c74a37" },
    { "kyazdani42/nvim-tree.lua", commit = "3e49d9b7484e21f0b24ebdf21b8b7af227ea97a6" },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
    { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" },
    { "akinsho/toggleterm.nvim", version = "v2.*" },
    { "ahmedkhalf/project.nvim", event = "VimEnter", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" },
    { "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" },
    { "goolord/alpha-nvim", commit = "a858e4e7b0805835e61fab2b54704450427d47c3" },
    { "kylechui/nvim-surround", commit = "ebdd22d2040798d0b5a5e50d72d940e95f308121" },
    { "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" },
    { "lervag/vimtex", commit = "336032a2f1b826365e6fc27667d55c273ec8cf99" },
    { "folke/todo-comments.nvim", commit = "02eb3019786d9083b93ab9457761899680c6f3ec" },
    { "ggandor/leap.nvim", commit = "f565a9c4d92245d8b619235bebeaa73cc38aa40e" },
    { "ggandor/flit.nvim", commit = "be110f9814a45788d10537fd59b3c76d956bb7ad" },
    { "NvChad/nvim-colorizer.lua", commit = "6c8b1495c3d2034188cc67c18e2ae5e8343cd504" },
    { "nacro90/numb.nvim", commit = "453c50ab921fa066fb073d2fd0f826cb036eaf7b" },
    { "ellisonleao/glow.nvim", commit = "764527caeb36cd68cbf3f6d905584750cb02229d" },
    { "rcarriga/nvim-notify", commit = "3a8ec89e1918ea2acbb9b22c5ac2006d31773052" },
    { "folke/which-key.nvim", event = "VeryLazy", commit = "6885b669523ff4238de99a7c653d47b081b5506d" },
    { "nvim-pack/nvim-spectre", commit = "ce73d505fdc45f16c1a04f6a98c1c1e114841708" },
    { "stevearc/dressing.nvim", commit = "1e60c07ae9a8557ac6395144606c3a5335ad47e0" },
    { "abecodes/tabout.nvim", commit = "be655cc7ce0f5d6d24eeaf8b36e82693fd2facca" },
    { "ghillb/cybu.nvim", commit = "aee926d1bc069194ae32e0e490d52fa3c1ed1bb7" },
    { "karb94/neoscroll.nvim", commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a" },
    { "is0n/jaq-nvim", commit = "051842d30357100e397dc6e904f813841c8edcb7" },
    {
        "iamcco/markdown-preview.nvim",
        commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
        build = "cd app && npm install",
        ft = "markdown",
    },
    { "kevinhwang91/nvim-bqf", commit = "8b62211ad7529c314e80b22968eef6ba275c781c", ft = "qf" },
    { "junegunn/vim-slash", commit = "31aee09b7ea8893a18fa34f65e63e364fc998444" },
    { "LunarVim/peek.lua", commit = "7e63517c232bf8d4c78b83b0b897c5d53c7fd569" },
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
    { "tamago324/lir.nvim", commit = "c1aeb96fae55bb6cac3d01ce5123a843d7235396" },
    { "b0o/schemastore.nvim", lazy = true, lazy = true, commit = "1dc606bf07e1419d785e04d6dbb8585987d817cc" },
    {
        "danymat/neogen",
        lazy = true,
        dependencies = "nvim-treesitter/nvim-treesitter",
        commit = "967b280d7d7ade52d97d06e868ec4d9a0bc59282",
    },
    { "monaqa/dial.nvim", commit = "d2d7a57fb030c82b8b0d6712d9c35dfb49d9aa3c" },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        commit = "a0e19486ccc1fb134f6ef7bf914d07bbb462e346",
    },
    { "folke/neodev.nvim", lazy = true, commit = "bb70e41640238b989bb6c2f94802851ff260f68d" },
    {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
        commit = "56b9ce31ec9d09d560fe8787c0920f76bc208297",
    },

    -- Colorschemes
    { "lunarvim/onedarker.nvim", commit = "4eaa5e8760832d23a84f8ad4e0ff012eacd2c01f" },
    { "lunarvim/darkplus.nvim", commit = "aa1f0a582dc897259b9cb8bebad64110da4d4cc4" },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, commit = "467d889ba82a74e26821c812aa8e70d7dff04c6c" },
    { "fladson/vim-kitty", commit = "d4c60f096b751c1462c80cbf42550e29c8cd2983" },

    -- Cmp plugins
    { "hrsh7th/nvim-cmp", lazy = true, commit = "cfafe0a1ca8933f7b7968a287d39904156f2c57d" }, -- The completion plugin
    { "hrsh7th/cmp-buffer", lazy = true, commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }, -- buffer completions
    { "hrsh7th/cmp-path", lazy = true, commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }, -- path completions
    { "saadparwaiz1/cmp_luasnip", lazy = true, commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp", lazy = true, commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" },
    { "hrsh7th/cmp-nvim-lua", lazy = true, commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },
    { "hrsh7th/cmp-emoji", lazy = true, commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0" },
    {
        "Saecki/crates.nvim",
        lazy = true,
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
    { "L3MON4D3/LuaSnip", lazy = true, commit = "37ffce053d4e20236efd43cecf7800e8ef40a997" },
    { "rafamadriz/friendly-snippets", lazy = true, commit = "009887b76f15d16f69ae1341f86a7862f61cf2a1" },

    -- LSP
    { "neovim/nvim-lspconfig", lazy = true, commit = "aeb76066212b09c7c01a3abb42fe82f0130ef402" },
    { "williamboman/mason.nvim", lazy = true, commit = "0efc7ceb29a933317e625544d3eb160e7c46dc81" },
    { "williamboman/mason-lspconfig.nvim", lazy = true, commit = "7a97a77eee486ae152d2c559a459eda7c8aa12aa" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true, commit = "6ca38efeb0406dea8da6c97f61d6f6ef30ab0576" },
    { "jose-elias-alvarez/null-ls.nvim", lazy = true, commit = "60b4a7167c79c7d04d1ff48b55f2235bf58158a7" },
    { "RRethy/vim-illuminate", commit = "59f69f90fbce5cf37741fb8e4aa040e78a0b3516" },
    { "folke/lsp-colors.nvim", commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3" },
    { "ray-x/lsp_signature.nvim", commit = "3694c1f3020ae671069f9a36749d7fa7fbd68b15" },
    { "j-hui/fidget.nvim", commit = "2cf9997d3bde2323a1a0934826ec553423005a26" },
    {
        "SmiteshP/nvim-navic",
        commit = "7e9d2b2b601149fecdccd11b516acb721e571fe6",
        dependencies = { "neovim/nvim-lspconfig" },
    },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", commit = "ec98b45c8280e5ef8c84028d4f38aa447276c002" },
    { "lvimuser/lsp-inlayhints.nvim", commit = "84ca3abe8aaecbb5b30ad89e4701d4a9c821b72c" },
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
    { "olexsmir/gopher.nvim", commit = "cc46546a93c7ccea39f1e008e6804b93559bec29" },

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
    { "mfussenegger/nvim-jdtls", commit = "87bdf2b216f3346abb099704c9bb45e5eb9df43a" },

    -- Telescope
    { "nvim-telescope/telescope.nvim", lazy = true, branch = "0.1.x" },
    { "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6",
        build = "make",
    },
    { "nvim-telescope/telescope-media-files.nvim", lazy = true, commit = "513e4ee385edd72bf0b35a217b7e39f84b6fe93c" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "89e5fa66cf53854f45cfcfae45afb93171cf5c05",
        build = function()
            require("nvim-treesitter.install").update { with_sync = true }
        end,
    },
    { "p00f/nvim-ts-rainbow", lazy = false, commit = "ef95c15a935f97c65a80e48e12fe72d49aacf9b9" },
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true, commit = "a0f89563ba36b3bacd62cf967b46beb4c2c29e52" },
    { "windwp/nvim-ts-autotag", lazy = true, commit = "fdefe46c6807441460f11f11a167a2baf8e4534b" },
    { "nvim-treesitter/playground", lazy = true, commit = "1290fdf6f2f0189eb3b4ce8073d3fda6a3658376" },
    { "nvim-treesitter/nvim-treesitter-context", lazy = true, commit = "0dd5eae6dbf226107da2c2041ffbb695d9e267c1" },
    { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, commit = "13edf91f47c91b390bb00e1df2f7cc1ca250af3a" },

    -- Git
    { "lewis6991/gitsigns.nvim", lazy = true, commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" },
    { "akinsho/git-conflict.nvim", lazy = true, commit = "c92604a64a2cce15a6e6a753f4501bcee06fa00a" },

    -- DAP
    { "mfussenegger/nvim-dap", lazy = true, commit = "764899df5ca39076acb08a447f7e5bd0b4fa3147" },
    { "mfussenegger/nvim-dap-python", lazy = true, commit = "52eb0830d3c8a7d283cc373c37ec78ebe0718d02" },
    { "leoluz/nvim-dap-go", lazy = true, commit = "c2902bb96c45e872d947d7e174775e652439add4" },
    { "rcarriga/nvim-dap-ui", lazy = true, commit = "8d0768a83f7b89bd8cb8811800bc121b9353f0b2" },

    -- nvim-test
    --  { "klen/nvim-test", commit = "32f162c27045fc712664b9ddbd33d3c550cb2bfc" },

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
    { "rouge8/neotest-rust", commit = "53db2f682e337c2188d81e8ecdf779bff869fb74" },
    { "nvim-neotest/neotest-python", commit = "a76fb6760fc2f653c2088f79152338cc99380cf1" },
    { "nvim-neotest/neotest-go", commit = "981406c12bd3c77eb434211a1b85b964ab5bbdd5" },
    { "haydenmeade/neotest-jest", commit = "821bb227e31259307db30c88671a1c3724f78637" },
    { "marilari88/neotest-vitest", commit = "8790a65f2a2dc4eb32551c908c2dbf3e02757701" },
}, {
    ui = {
        border = "rounded",
    },
})
