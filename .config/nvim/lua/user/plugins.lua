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
    use { "nvim-lua/plenary.nvim", commit = "986ad71ae930c7d96e812734540511b4ca838aa2" } -- Useful lua functions used by lots of plugins
    use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" } -- Autopairs, integrates with both cmp and treesitter
    use { "numToStr/Comment.nvim", commit = "350bf0cb47bfb2a48ddca79475888bc333c74a37" }
    use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
    use { "kyazdani42/nvim-tree.lua", commit = "3e49d9b7484e21f0b24ebdf21b8b7af227ea97a6" }
    use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
    use { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" }
    use { "akinsho/toggleterm.nvim", tag = "v2.*" }
    use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" }
    use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }
    use { "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" }
    use { "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" }
    use { "kylechui/nvim-surround", commit = "a498d10222e8712b42d9115b9748449c2d1cf645" }
    use { "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" }
    use { "lervag/vimtex", commit = "61eb22574b0234ded1ec9cfeecf140999865285b" }
    use { "folke/todo-comments.nvim", commit = "02eb3019786d9083b93ab9457761899680c6f3ec" }
    use { "ggandor/leap.nvim", commit = "aba53d7a8870426bea89eeca6c3b265d1f94c584" }
    use { "NvChad/nvim-colorizer.lua", commit = "6c8b1495c3d2034188cc67c18e2ae5e8343cd504" }
    use { "nacro90/numb.nvim", commit = "453c50ab921fa066fb073d2fd0f826cb036eaf7b" }
    use { "ellisonleao/glow.nvim", commit = "764527caeb36cd68cbf3f6d905584750cb02229d" }
    use { "rcarriga/nvim-notify", commit = "3a8ec89e1918ea2acbb9b22c5ac2006d31773052" }
    use { "folke/which-key.nvim", commit = "6885b669523ff4238de99a7c653d47b081b5506d" }
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
    use { "junegunn/vim-slash", commit = "31aee09b7ea8893a18fa34f65e63e364fc998444" }
    use { "klen/nvim-test", commit = "32f162c27045fc712664b9ddbd33d3c550cb2bfc" }
    use { "LunarVim/peek.lua", commit = "7e63517c232bf8d4c78b83b0b897c5d53c7fd569" }
    use {
        "jiaoshijie/undotree",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        commit = "6cb7e65e03871d2567d2c44745d3de57d07ca1fd",
    }
    use {
        "0x100101/lab.nvim",
        run = "cd js && npm ci",
        requires = { "nvim-lua/plenary.nvim" },
        commit = "733b4dd2c1b87013291c21d80afbe5255712d1d3",
    }
    use { "tamago324/lir.nvim", commit = "c1aeb96fae55bb6cac3d01ce5123a843d7235396" }
    use { "b0o/schemastore.nvim", commit = "687fc5aca8eef79278a01345f1a93dcc68453f29" }

    -- Colorschemes
    use { "lunarvim/onedarker.nvim", commit = "4eaa5e8760832d23a84f8ad4e0ff012eacd2c01f" }
    use { "lunarvim/darkplus.nvim", commit = "aa1f0a582dc897259b9cb8bebad64110da4d4cc4" }
    use { "folke/tokyonight.nvim", commit = "4092905fc570a721128af73f6bf78e5d47f5edce" }

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
    use { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }

    -- LSP
    use { "neovim/nvim-lspconfig", commit = "d4eb971db353ccf78cefb3be1b05483b69ec1e69" }
    use { "williamboman/mason.nvim", commit = "812c1271c6c8e44b197d2939906ac663e0c00cff" }
    use { "williamboman/mason-lspconfig.nvim", commit = "df37cc7ea1668eaedef3a966cdb02ae71dd1481a" }
    use { "WhoIsSethDaniel/mason-tool-installer.nvim", commit = "ca4c6da43ab1f5687dc35da13dd6504acc912708" }
    use { "jose-elias-alvarez/null-ls.nvim", commit = "c333ecce37ee5f096f17754901e4ec4827041166" }
    use { "RRethy/vim-illuminate", commit = "59f69f90fbce5cf37741fb8e4aa040e78a0b3516" }
    use { "folke/lsp-colors.nvim", commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3" }
    use { "ray-x/lsp_signature.nvim", commit = "3694c1f3020ae671069f9a36749d7fa7fbd68b15" }
    use { "j-hui/fidget.nvim", commit = "46d1110435f1f023c22fa95bb10b3906aecd7bde" }
    use {
        "SmiteshP/nvim-navic",
        commit = "94bf6fcb1dc27bdad230d9385da085e72c390019",
        requires = { "neovim/nvim-lspconfig" },
    }
    use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", commit = "db67e94c813aae166c3d2f119ea7d2e85164922a" }
    use { "lvimuser/lsp-inlayhints.nvim", commit = "9bcd6fe25417b7808fe039ab63d4224f2071d24a" }

    -- Go
    use {
        "fatih/vim-go",
        commit = "b7506c6da8ea3a88e268a91aa6630be3e26a20a9",
        run = ":GoUpdateBinaries errcheck fillstruct gomodifytags impl iferr",
    }

    -- Rust
    use {
        "simrat39/rust-tools.nvim",
        commit = "86a2b4e31f504c00715d0dd082a6b8b5d4afbf03",
    }

    -- Lua
    use {
        "folke/lua-dev.nvim",
        commit = "f5c31936fe06fcbeb59b98f69f74f9c2f91abaec",
    }

    -- Java
    use { "mfussenegger/nvim-jdtls", commit = "87bdf2b216f3346abb099704c9bb45e5eb9df43a" }

    -- Telescope
    use { "nvim-telescope/telescope.nvim", commit = "b5833a682c511885887373aad76272ad70f7b3c2" }
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
        commit = "a60aa7b2e1dd9219c6356f65ba48bdbd50090abd",
        run = function()
            require("nvim-treesitter.install").update { with_sync = true }
        end,
    }
    use { "p00f/nvim-ts-rainbow", commit = "fad8badcd9baa4deb2cf2a5376ab412a1ba41797" }
    use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "37a97a04c39f26fffe7745815517e1ce1a0eb3be" }
    use { "windwp/nvim-ts-autotag", commit = "044a05c4c51051326900a53ba98fddacd15fea22" }
    use { "nvim-treesitter/playground", commit = "ce7e4b757598f1c785ed0fd94fc65959acd7d39c" }
    use { "nvim-treesitter/nvim-treesitter-context", commit = "245bb4381edf43ddb1fde7e78d4119dbfc12ea41" }
    use { "nvim-treesitter/nvim-treesitter-textobjects", commit = "e63c2ff8e38fad77299dd74e14c7c9360e1b3181" }

    -- Git
    use { "lewis6991/gitsigns.nvim", commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" }
    use { "akinsho/git-conflict.nvim", commit = "80bc8931d4ed8c8c4d289a08e1838fcf4741408d" }

    -- DAP
    use { "mfussenegger/nvim-dap", commit = "764899df5ca39076acb08a447f7e5bd0b4fa3147" }
    use { "rcarriga/nvim-dap-ui", commit = "8d0768a83f7b89bd8cb8811800bc121b9353f0b2" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
