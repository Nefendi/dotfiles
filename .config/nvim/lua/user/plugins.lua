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
    -- Autopairs, integrates with both cmp and treesitter
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require "user.autopairs"
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require "user.comment"
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        event = "VeryLazy",
        config = function()
            require "user.nvim-tree"
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
    },
    { "moll/vim-bbye", event = "BufReadPost" },
    {
        "nvim-lualine/lualine.nvim",
        event = "BufReadPost",
        config = function()
            require "user.lualine"
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        version = "v2.*",
        event = "VeryLazy",
        config = function()
            require "user.toggleterm"
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        config = function()
            require "user.project"
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        config = function()
            require "user.indentline"
        end,
    },
    {
        "goolord/alpha-nvim",
        lazy = false,
        config = function()
            require "user.alpha"
        end,
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require "user.surround"
        end,
    },
    { "lervag/vimtex", ft = "tex" },
    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        config = function()
            require "user.todo-comments"
        end,
    },
    {
        "ggandor/leap.nvim",
        event = "BufReadPost",
        config = function()
            require "user.leap"
        end,
    },
    {
        "ggandor/flit.nvim",
        event = "BufReadPost",
        config = function()
            require "user.flit"
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPost",
        config = function()
            require "user.nvim-colorizer"
        end,
    },
    {
        "nacro90/numb.nvim",
        event = "BufReadPost",
        config = function()
            require "user.numb"
        end,
    },
    {
        "ellisonleao/glow.nvim",
        ft = "markdown",
        config = function()
            require "user.glow"
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require "user.notify"
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require "user.which-key"
        end,
    },
    {
        "nvim-pack/nvim-spectre",
        event = "BufReadPost",
        config = function()
            require "user.spectre"
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require "user.dressing"
        end,
    },
    {
        "abecodes/tabout.nvim",
        event = "InsertEnter",
        config = function()
            require "user.tabout"
        end,
    },
    {
        "ghillb/cybu.nvim",
        event = "VeryLazy",
        config = function()
            require "user.cybu"
        end,
    },
    {
        "karb94/neoscroll.nvim",
        event = "BufReadPost",
        config = function()
            require "user.neoscroll"
        end,
    },
    {
        "is0n/jaq-nvim",
        cmd = "Jaq",
        config = function()
            require "user.jaq"
        end,
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
    {
        "junegunn/vim-slash",
        event = "BufReadPost",
        config = function()
            require "user.vim-slash"
        end,
    },
    { "LunarVim/peek.lua", event = "BufReadPost" },
    {
        "jiaoshijie/undotree",
        event = "VeryLazy",
        config = function()
            require "user.undotree"
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "0x100101/lab.nvim",
        enabled = false,
        cmd = "Lab",
        config = function()
            require "user.lab"
        end,
        build = "cd js && npm ci",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "tamago324/lir.nvim",
        lazy = false,
        config = function()
            require "user.lir"
        end,
    },
    { "b0o/schemastore.nvim" },
    {
        "danymat/neogen",
        event = "VeryLazy",
        config = function()
            require "user.neogen"
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        "monaqa/dial.nvim",
        keys = { "<C-a>", "<C-x>", { "<C-a>", mode = "v" }, { "<C-x>", mode = "v" } },
        config = function()
            require "user.dial"
        end,
    },
    {
        "utilyre/barbecue.nvim",
        event = "VeryLazy",
        config = function()
            require "user.barbecue"
        end,
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "kosayoda/nvim-lightbulb",
        event = "BufReadPost",
        config = function()
            require "user.lightbulb"
        end,
        dependencies = "antoinemadec/FixCursorHold.nvim",
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require "user.noice"
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "fedepujol/move.nvim",
        event = "VeryLazy",
    },

    -- Colorschemes
    { "lunarvim/onedarker.nvim" },
    { "lunarvim/darkplus.nvim" },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "fladson/vim-kitty", ft = "kitty" },

    -- Cmp plugins
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            require "user.cmp"
        end,
        dependencies = {
            "hrsh7th/cmp-buffer", -- buffer completions
            "hrsh7th/cmp-path", -- path completions
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "hrsh7th/cmp-nvim-lsp",
        },
    }, -- The completion plugin
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-emoji", event = "InsertEnter" },
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        config = function()
            require "user.crates"
        end,
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "David-Kunz/cmp-npm",
        event = "BufRead package.json",
        config = function()
            require "user.cmp-npm"
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "tzachar/cmp-tabnine",
        event = "InsertEnter",
        config = function()
            require "user.tabnine"
        end,
        dependencies = { "hrsh7th/nvim-cmp" },
        build = "./install.sh",
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        event = "InsertEnter",
        config = function()
            require "user.luasnip"
        end,
    },
    { "rafamadriz/friendly-snippets" },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            require "user.lsp"
        end,
    },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    { "nvimtools/none-ls.nvim" },
    {
        "RRethy/vim-illuminate",
        event = "BufReadPost",
        config = function()
            require "user.illuminate"
        end,
    },
    { "ray-x/lsp_signature.nvim" },
    {
        "smjonas/inc-rename.nvim",
        event = "BufReadPost",
        config = function()
            require "user.inc-rename"
        end,
    },
    {
        "SmiteshP/nvim-navic",
        event = "VeryLazy",
        config = function()
            require "user.navic"
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
    {
        "lvimuser/lsp-inlayhints.nvim",
        event = "LspAttach",
        config = function()
            require "user.lsp.lsp-inlay-hints"
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "BufReadPost",
        config = function()
            require "user.ufo"
        end,
        dependencies = "kevinhwang91/promise-async",
    },
    {
        "luukvbaal/statuscol.nvim",
        event = "BufReadPost",
        config = function()
            require "user.statuscol"
        end,
    },

    -- Go
    {
        "olexsmir/gopher.nvim",
        ft = { "go", "gomod", "gowork", "gosum" },
        config = function()
            require "user.gopher"
        end,
    },

    -- Rust
    {
        "simrat39/rust-tools.nvim",
    },

    -- Lua
    { "folke/neodev.nvim" },

    -- Java
    { "mfussenegger/nvim-jdtls" },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        event = "VeryLazy",
        config = function()
            require "user.telescope"
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    { "nvim-telescope/telescope-media-files.nvim" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function()
            require "user.treesitter"
        end,
        build = ":TSUpdate",
    },
    { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "windwp/nvim-ts-autotag", event = "BufReadPost" },
    { "nvim-treesitter/playground", event = "BufReadPost" },
    { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPost" },
    { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPost" },
    { "IndianBoy42/tree-sitter-just" },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require "user.gitsigns"
        end,
    },
    {
        "akinsho/git-conflict.nvim",
        event = "VeryLazy",
        config = function()
            require "user.git-conflict"
        end,
    },

    -- DAP
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        config = function()
            require "user.dap"
        end,
    },
    { "mfussenegger/nvim-dap-python" },
    { "leoluz/nvim-dap-go" },
    { "rcarriga/nvim-dap-ui" },
    { "LiadOz/nvim-dap-repl-highlights" },

    -- nvim-test
    -- {
    --     "klen/nvim-test",
    --     event = "VeryLazy",
    --     config = function()
    --         require "user.nvim-test"
    --     end,
    -- },

    -- Neotest
    {
        "nvim-neotest/neotest",
        event = "VeryLazy",
        config = function()
            require "user.neotest"
        end,

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        },
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
    checker = {
        enabled = false,
    },
})
