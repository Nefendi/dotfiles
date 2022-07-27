local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        prompt_border = "rounded",
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use { "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" } -- Have packer manage itself
    use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" } -- Useful lua functions used by lots of plugins
    use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" } -- Autopairs, integrates with both cmp and treesitter
    use { "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }
    use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
    use { "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" }
    use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
    use { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" }
    use { "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" }
    use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" }
    use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }
    use { "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" }
    use { "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" }
    use { "kylechui/nvim-surround", commit = "a498d10222e8712b42d9115b9748449c2d1cf645" }
    use { "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" }
    use { "lervag/vimtex", commit = "61eb22574b0234ded1ec9cfeecf140999865285b" }
    use { "folke/todo-comments.nvim", commit = "98b1ebf198836bdc226c0562b9f906584e6c400e" }
    use { "ggandor/leap.nvim", commit = "539d6e6936462a4685bd6c895ce46b5ff1c1826b" }
    use { "NvChad/nvim-colorizer.lua", commit = "6c8b1495c3d2034188cc67c18e2ae5e8343cd504" }
    use { "nacro90/numb.nvim", commit = "453c50ab921fa066fb073d2fd0f826cb036eaf7b" }
    use { "ellisonleao/glow.nvim", commit = "764527caeb36cd68cbf3f6d905584750cb02229d" }
    use { "rcarriga/nvim-notify", commit = "7caeaaef257ecbe95473ec79e5a82757b544f1fd" }
    use { "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" }
    use { "nvim-pack/nvim-spectre", commit = "a52139da068ee4d0860810af7c6b6d48d3cde603" }
    use { "stevearc/dressing.nvim", commit = "1e60c07ae9a8557ac6395144606c3a5335ad47e0" }
    use { "abecodes/tabout.nvim", commit = "be655cc7ce0f5d6d24eeaf8b36e82693fd2facca", wants = { "nvim-treesitter" } }
    use { "ghillb/cybu.nvim", commit = "aee926d1bc069194ae32e0e490d52fa3c1ed1bb7" }
    use { "karb94/neoscroll.nvim", commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a" }
    use { "is0n/jaq-nvim", commit = "051842d30357100e397dc6e904f813841c8edcb7" }
    use {
        "iamcco/markdown-preview.nvim",
        commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
        run = "cd app && npm install",
        ft = "markdown",
    }
    use { "kevinhwang91/nvim-bqf", commit = "8b62211ad7529c314e80b22968eef6ba275c781c", ft = "qf" }

    -- Colorschemes
    use { "lunarvim/onedarker.nvim", commit = "4eaa5e8760832d23a84f8ad4e0ff012eacd2c01f" }
    use { "projekt0n/github-nvim-theme", commit = "1cc4a8d508bc6b846c72b9e629e8188ac24d0f13" }
    use { "ellisonleao/gruvbox.nvim", commit = "3352c12c083d0ab6285a9738b7679e24e7602411" }
    use { "lunarvim/darkplus.nvim", commit = "93fb1fd7b2635192d909e11a77256d5822aed5c8" }
    use { "Mofiqul/vscode.nvim", commit = "ba65e6ad9a486737dcd912a1ae58b940e2b38a5c" }

    -- Cmp plugins
    use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
    use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
    use { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" } -- path completions
    use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
    use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
    use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }
    use { "hrsh7th/cmp-emoji", commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0" }
    use {
        "Saecki/crates.nvim",
        commit = "cceea1a4f2d0131f43b6d17ad5c793aded19443b",
        requires = { "nvim-lua/plenary.nvim" },
    }
    use {
        "David-Kunz/cmp-npm",
        commit = "4b6166c3feeaf8dae162e33ee319dc5880e44a29",
        requires = { "nvim-lua/plenary.nvim" },
    }
    use {
        "tzachar/cmp-tabnine",
        commit = "e23d32a76304496aade4e4b285751a6a8b505491",
        requires = { "hrsh7th/nvim-cmp" },
        run = "./install.sh",
    }

    -- Snippets
    use { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }
    use { "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }

    -- LSP
    use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" }
    use { "williamboman/mason.nvim", commit = "269ee222f76e705619da2c0130c0a06e76419b88" }
    use { "williamboman/mason-lspconfig.nvim", commit = "9dc0291fd9e3bdb56245f6bef95223cac9865231" }
    use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }
    use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }
    use { "folke/lsp-colors.nvim", commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3" }
    use { "ray-x/lsp_signature.nvim", commit = "3694c1f3020ae671069f9a36749d7fa7fbd68b15" }
    use { "j-hui/fidget.nvim", commit = "46d1110435f1f023c22fa95bb10b3906aecd7bde" }
    use {
        "SmiteshP/nvim-navic",
        commit = "94bf6fcb1dc27bdad230d9385da085e72c390019",
        requires = { "neovim/nvim-lspconfig" },
    }
    use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", commit = "db67e94c813aae166c3d2f119ea7d2e85164922a" }
    use { "lvimuser/lsp-inlayhints.nvim", branch = "readme" }

    -- Go
    use {
        "fatih/vim-go",
        commit = "b7506c6da8ea3a88e268a91aa6630be3e26a20a9",
        run = ":GoUpdateBinaries errcheck fillstruct gomodifytags impl iferr",
    }

    -- Rust
    use {
        "simrat39/rust-tools.nvim",
        commit = "11dcd674781ba68a951ab4c7b740553cae8fe671",
    }

    -- Lua
    use {
        "folke/lua-dev.nvim",
        commit = "f5c31936fe06fcbeb59b98f69f74f9c2f91abaec",
    }

    -- Telescope
    use { "nvim-telescope/telescope.nvim", commit = "bb8db6eda25399bef00074978bb13771b92e99e1" }
    use { "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6",
        run = "make",
    }
    use { "nvim-telescope/telescope-media-files.nvim", commit = "513e4ee385edd72bf0b35a217b7e39f84b6fe93c" }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        commit = "365f0eb75f4b8de4655476388c99aaa97f149ded",
    }
    use { "p00f/nvim-ts-rainbow", commit = "18cb3a45e0ff843d48e8637a36b9cc6cd89d71b0" }
    use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" }
    use { "windwp/nvim-ts-autotag", commit = "044a05c4c51051326900a53ba98fddacd15fea22" }
    use { "nvim-treesitter/playground", commit = "ce7e4b757598f1c785ed0fd94fc65959acd7d39c" }

    -- Git
    use { "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" }
    use { "f-person/git-blame.nvim", commit = "1bb73289929107309d2d90f7582ece5e9436bfd8" }
    use { "akinsho/git-conflict.nvim", commit = "80bc8931d4ed8c8c4d289a08e1838fcf4741408d" }

    -- DAP
    use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
    use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
    use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
