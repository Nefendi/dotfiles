lvim.format_on_save.timeout = 5000

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_italic = true

lvim.colorscheme = "nord"

vim.opt.background = "dark"
vim.opt.relativenumber = true
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120
vim.opt.linebreak = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require('lualine').setup {
  options = {
    theme = 'nord'
  }
}

local components = require 'lvim.core.lualine.components'

lvim.builtin.lualine.sections.lualine_x = {
  components.treesitter,
  components.lsp,
  components.filetype,
  components.encoding,
  components.spaces,
}

lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.lsp.diagnostics.virtual_text = true

vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    width = 25,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = {"<Esc>", "q"},
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
        File = {icon = "", hl = "TSURI"},
        Module = {icon = "", hl = "TSNamespace"},
        Namespace = {icon = "", hl = "TSNamespace"},
        Package = {icon = "", hl = "TSNamespace"},
        Class = {icon = "𝓒", hl = "TSType"},
        Method = {icon = "ƒ", hl = "TSMethod"},
        Property = {icon = "", hl = "TSMethod"},
        Field = {icon = "", hl = "TSField"},
        Constructor = {icon = "", hl = "TSConstructor"},
        Enum = {icon = "ℰ", hl = "TSType"},
        Interface = {icon = "ﰮ", hl = "TSType"},
        Function = {icon = "", hl = "TSFunction"},
        Variable = {icon = "", hl = "TSConstant"},
        Constant = {icon = "", hl = "TSConstant"},
        String = {icon = "𝓐", hl = "TSString"},
        Number = {icon = "#", hl = "TSNumber"},
        Boolean = {icon = "⊨", hl = "TSBoolean"},
        Array = {icon = "", hl = "TSConstant"},
        Object = {icon = "⦿", hl = "TSType"},
        Key = {icon = "🔐", hl = "TSType"},
        Null = {icon = "NULL", hl = "TSType"},
        EnumMember = {icon = "", hl = "TSField"},
        Struct = {icon = "𝓢", hl = "TSType"},
        Event = {icon = "🗲", hl = "TSType"},
        Operator = {icon = "+", hl = "TSOperator"},
        TypeParameter = {icon = "𝙏", hl = "TSParameter"}
    }
}

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- nvim-tree
lvim.builtin.nvimtree.setup.view.width = 50

-- Telescope
local telescope = lvim.builtin.telescope
local actions = require "telescope.actions"

telescope.defaults.mappings.i = {
  ["<C-n>"] = actions.cycle_history_next,
  ["<C-p>"] = actions.cycle_history_prev,

  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
}

telescope.defaults.vimgrep_arguments = {
    "rg",
    "--hidden",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "-g",
    "!.git",
    "-g",
    "!node_modules"
}

telescope.defaults.pickers.find_files.find_command = {'rg', '--files', '--hidden', '-g', '!.git', '-g', '!node_modules' }
telescope.defaults.pickers.live_grep.vimgrep_arguments = {
    "rg",
    "--hidden",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "-g",
    "!.git",
    "-g",
    "!node_modules"
}

require("telescope").setup(
    {
        pickers = {
            find_files = {
                find_command = {'rg', '--files', '--hidden', '-g', '!.git', '-g', '!node_modules' }
            },
         live_grep = {
              vimgrep_arguments = {
                "rg",
                "--hidden",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "-g",
                "!.git",
                "-g",
                "!node_modules"
              }
            },
        }
    }
)

require("telescope").load_extension("media_files")

telescope.extensions.media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
}


lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Document diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace diagnostics" },
}
lvim.builtin.which_key.mappings["o"] = { "<cmd>SymbolsOutline<CR>", "Symbols"}
lvim.builtin.which_key.mappings["G"] = {
  name = "+Go",
  b = { "<cmd>GoBuild<cr>", "Build" },
  r = { "<cmd>GoRun<cr>", "Run" },
  t = { "<cmd>GoTest<cr>", "Test" },
  c = { "<cmd>GoCoverageToggle<cr>", "Toggle coverage" },
  g = { "<cmd>GoGenerate<cr>", "Generate"},
  i = { "<cmd>GoImpl<cr>", "Implement"},
}
lvim.builtin.which_key.mappings["a"] = { "<cmd>:wa<cr>", "Save All" }
lvim.builtin.which_key.mappings["m"] = {
  name = "+Markdown",
  p = { "<cmd>:Glow<cr>", "Preview" },
}
lvim.builtin.which_key.mappings["s"] = vim.tbl_extend("force", { s = { "<cmd>Telescope grep_string<CR>", "Grep string" }},
    lvim.builtin.which_key.mappings["s"]) 

lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.treesitter.ensure_installed = "maintained"

lvim.builtin.treesitter.highlight.enabled = true


-- emmet_ls
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {
          'html',
          'css',
          'scss',
          'javascript',
          'typescript',
          'typescriptreact',
          'javascriptreact',
        };
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

lspconfig.emmet_ls.setup{ capabilities = capabilities; }




local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    exe = "black"
  },
  {
    exe = "isort"
  },
  {
    exe = "clang-format"
  },
  {
    exe = "prettier",
    filetypes = { "javascript",
                  "javascriptreact",
                  "typescript",
                  "typescriptreact",
                  "html",
                  "css",
                  "scss"
        }
  }
}

local linters = require "lvim.lsp.null-ls.linters"

linters.setup {
  {
    exe = "flake8"
  },
  {
    exe = "pylint"
  },
  {
    exe = "shellcheck",
    args = { "--severity", "warning" }
  }
}

-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = TroubleToggle
  },
  {
    "RRethy/nvim-base16"
  },
  {
    "fatih/vim-go",
    run = function()
      vim.cmd (":GoUpdateBinaries")
    end,
    config = function()
      vim.cmd ("let g:go_bin_path = expand('~/go/bin')")
      vim.cmd ("let g:go_def_mapping_enabled = 0")
      -- vim.cmd ("let g:go_fmt_command = 'goimports'")
      -- vim.cmd ("let g:go_gopls_enabled = 0")
      -- vim.cmd ("let g:go_fmt_autosave = 0")
      -- vim.cmd ("let g:go_mod_fmt_autosave = 0")
      -- vim.cmd ("let g:go_code_completion_enabled = 0")
      -- vim.cmd ("let g:go_imports_autosave = 0")
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          cmd = { vim.fn.stdpath "data" .. "/lsp_servers/rust/rust-analyzer" },
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                    extraArgs = {
                         "--target-dir", "/tmp/rust-analyzer-check",
                    },
                },
            },
        },
    }
      })
    end,
    ft = { "rust", "rs" },
  },
  {
    "Saecki/crates.nvim",
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },
  {
    "David-Kunz/cmp-npm",
    requires = { "nvim-lua/plenary.nvim" }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char_list = {'|', '¦', '┆', '┊'}
      vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
      vim.g.indent_blankline_buftype_exclude = {"terminal"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function() require"lsp_signature".on_attach() end,
    event = "BufRead"
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
    require("numb").setup {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
    }
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "*" }, {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
    end,
  },
  {
    "simrat39/symbols-outline.nvim"
  },
  {
    "ellisonleao/glow.nvim"
  },
  -- {
  --   "NTBBloodbath/doom-one.nvim",
  --   config = function()
  --       require('doom-one').setup({
  --           cursor_coloring = false,
  --           terminal_colors = true,
  --           italic_comments = true,
  --           enable_treesitter = true,
  --           transparent_background = false,
  --           pumblend = {
  --               enable = true,
  --               transparency_amount = 20,
  --           },
  --           plugins_integrations = {
  --               neorg = true,
  --               barbar = true,
  --               bufferline = true,
  --               gitgutter = false,
  --               gitsigns = true,
  --               telescope = true,
  --               neogit = true,
  --               nvim_tree = true,
  --               dashboard = true,
  --               startify = true,
  --               whichkey = true,
  --               indent_blankline = true,
  --               vim_illuminate = true,
  --               lspsaga = false,
  --           },
  --       })
  --   end,
  -- },
  {
    "p00f/nvim-ts-rainbow",
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          extended_mode = false,
          max_file_lines = nil,
          colors = {
            "#bf616a",
            "#d08770",
            "#ebcb8b",
            "#a3be8c",
            "#88c0d0",
            "#5e81ac",
            "#b48ead",
          }
        }
      }
    end,
  },
  {
    "folke/lsp-colors.nvim",
  },
  {
    "nvim-telescope/telescope-media-files.nvim"
  },
  {
    "shaunsingh/nord.nvim"
  }
}
