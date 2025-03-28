return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local which_key = require "which-key"

            local icons = require "config.icons"

            local neotest = require "neotest"

            local setup = {
                preset = "modern",
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    spelling = {
                        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20, -- how many suggestions should be shown in the list?
                    }, -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    presets = {
                        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                        motions = false, -- adds help for motions
                        text_objects = true, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true, -- bindings for prefixed with g
                    },
                },
                icons = {
                    breadcrumb = icons.ui.DoubleRightChevron, -- symbol used in the command line area that shows your active key combo
                    separator = icons.ui.RightArrow, -- symbol used between a key and it's label
                    group = "+", -- symbol prepended to a group
                },
                keys = {
                    scroll_down = "<c-d>", -- binding to scroll down inside the popup
                    scroll_up = "<c-u>", -- binding to scroll up inside the popup
                },
                win = {
                    border = "rounded", -- none, single, double, shadow
                    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                    wo = {
                        winblend = 0,
                    },
                },
                layout = {
                    height = { min = 4, max = 25 }, -- min and max height of the columns
                    width = { min = 20, max = 50 }, -- min and max width of the columns
                    spacing = 3, -- spacing between columns
                    align = "center", -- align columns left, center or right
                },
                show_help = false, -- show help message on the command line when the popup is visible
            }

            local mappings = {
                { "<leader> ", "<cmd>Telescope find_files<cr>", desc = "Find Files", nowait = true, remap = false },
                {
                    "<leader>/",
                    '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>',
                    desc = "Comment",
                    nowait = true,
                    remap = false,
                },
                { "<leader>P", "<cmd>Telescope projects<cr>", desc = "Projects", nowait = true, remap = false },
                {
                    "<leader>C",
                    function()
                        require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
                    end,
                    desc = "Edit Neovim Config",
                    nowait = true,
                    remap = false,
                },
                { "<leader>T", group = "Treesitter", nowait = true, remap = false },
                { "<leader>Tc", "<cmd>TSContextToggle<cr>", desc = "Toggle Context", nowait = true, remap = false },
                { "<leader>Ti", "<cmd>Inspect<cr>", desc = "Inspect", nowait = true, remap = false },
                { "<leader>Tt", "<cmd>InspectTree<cr>", desc = "Inspect Tree", nowait = true, remap = false },
                { "<leader>Tr", "<cmd>TSToggle rainbow<cr>", desc = "Toggle Rainbow", nowait = true, remap = false },
                { "<leader>a", "<cmd>wa<CR>", desc = "Write All", nowait = true, remap = false },
                { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers", nowait = true, remap = false },
                { "<leader>c", "<cmd>lua Snacks.bufdelete()<CR>", desc = "Close Buffer", nowait = true, remap = false },
                { "<leader>d", group = "Debug", nowait = true, remap = false },
                {
                    "<leader>dC",
                    function()
                        local condition = vim.fn.input "Condition: "
                        require("dap").set_breakpoint(condition)
                    end,
                    desc = "Conditional Breakpoint",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>dg",
                    function()
                        local log_message = vim.fn.input "Log message: "
                        require("dap").set_breakpoint(nil, nil, log_message)
                    end,
                    desc = "Logpoint",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>dX",
                    "<cmd>lua require'dap'.clear_breakpoints()<cr>",
                    desc = "Clear Breakpoints",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>dL",
                    function()
                        require("dap").list_breakpoints()
                        vim.cmd "copen"
                    end,
                    desc = "List Breakpoints",
                    nowait = true,
                    remap = false,
                },
                { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Out", nowait = true, remap = false },
                {
                    "<leader>dR",
                    "<cmd>lua require'dap'.repl.toggle()<cr>",
                    desc = "Repl",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>db",
                    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
                    desc = "Breakpoint",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>dc",
                    "<cmd>lua require'dap'.continue()<cr>",
                    desc = "Continue",
                    nowait = true,
                    remap = false,
                },
                { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Into", nowait = true, remap = false },
                { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Last", nowait = true, remap = false },
                { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Over", nowait = true, remap = false },
                { "<leader>dr", "<cmd>lua require'dap'.restart()<cr>", desc = "Restart", nowait = true, remap = false },
                { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "UI", nowait = true, remap = false },
                { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Exit", nowait = true, remap = false },
                {
                    "<leader>de",
                    "<cmd>lua require'dapui'.eval()<cr>",
                    desc = "Evaluate expression",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>e",
                    function()
                        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                    end,
                    desc = "Open Explorer (directory of current file)",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>E",
                    function()
                        require("mini.files").open(vim.uv.cwd(), true)
                    end,
                    desc = "Open Explorer (current working directory)",
                    nowait = true,
                    remap = false,
                },
                { "<leader>f", group = "Find", nowait = true, remap = false },
                { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
                { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Highlights", nowait = true, remap = false },
                { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
                { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
                {
                    "<leader>fT",
                    "<cmd>Telescope grep_string<cr>",
                    desc = "Find Current Word",
                    nowait = true,
                    remap = false,
                },
                { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
                {
                    "<leader>ff",
                    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
                    desc = "Current Buffer Fuzzy Find",
                    nowait = true,
                    remap = false,
                },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", nowait = true, remap = false },
                {
                    "<leader>fp",
                    "<cmd>lua Snacks.picker.files()<CR>",
                    desc = "Files with preview",
                    nowait = true,
                    remap = false,
                },
                { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
                {
                    "<leader>fn",
                    "<cmd>Telescope notify initial_mode=normal<cr>",
                    desc = "Find Notifications",
                    nowait = true,
                    remap = false,
                },
                { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", nowait = true, remap = false },
                {
                    "<leader>fs",
                    "<cmd>TodoTelescope initial_mode=normal<cr>",
                    desc = "TODO comments",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>ft",
                    require("config.multigrep").live_multigrep,
                    desc = "Find Text",
                    nowait = true,
                    remap = false,
                },
                { "<leader>g", group = "Git", nowait = true, remap = false },
                {
                    "<leader>gL",
                    "<cmd>Gitsigns toggle_current_line_blame<cr>",
                    desc = "Toggle Blame",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>gh",
                    "<cmd>Gitsigns toggle_linehl<cr>",
                    desc = "Toggle Line Highlights",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>gb",
                    "<cmd>Telescope git_branches<cr>",
                    desc = "Checkout Branch",
                    nowait = true,
                    remap = false,
                },
                { "<leader>gc", group = "Conflicts", nowait = true, remap = false },
                {
                    "<leader>gcb",
                    "<cmd>GitConflictChooseBoth<cr>",
                    desc = "Accept Both Changes",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>gcc",
                    "<cmd>GitConflictChooseOurs<cr>",
                    desc = "Accept Current Changes",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>gci",
                    "<cmd>GitConflictChooseTheirs<cr>",
                    desc = "Accept Incoming Changes",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>gcn",
                    "<cmd>GitConflictNextConflict<cr>",
                    desc = "Next Conflict",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>gcp",
                    "<cmd>GitConflictPrevConflict<cr>",
                    desc = "Previous Conflict",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>gcr",
                    "<cmd>GitConflictChooseNone<cr>",
                    desc = "Reject Both Changes",
                    nowait = true,
                    remap = false,
                },
                { "<leader>gcs", "<cmd>GitConflictListQf<cr>", desc = "Show Conflicts", nowait = true, remap = false },
                { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff", nowait = true, remap = false },
                {
                    "<leader>gD",
                    "<cmd>Gitsigns toggle_word_diff<cr>",
                    desc = "Word Diff",
                    nowait = true,
                    remap = false,
                },
                { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit", nowait = true, remap = false },
                { "<leader>gl", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line", nowait = true, remap = false },
                { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk", nowait = true, remap = false },
                { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No HL", nowait = true, remap = false },
                { "<leader>l", group = "LSP", nowait = true, remap = false },
                {
                    "<leader>lD",
                    "<cmd>Telescope diagnostics<cr>",
                    desc = "Workspace Diagnostics",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lF",
                    "<cmd>LspToggleAutoFormat<cr>",
                    desc = "Toggle Autoformat",
                    nowait = true,
                    remap = false,
                },
                { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Installer Info", nowait = true, remap = false },
                {
                    "<leader>lS",
                    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                    desc = "Workspace Symbols",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>la",
                    "<cmd>lua vim.lsp.buf.code_action()<cr>",
                    desc = "Code Action",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lc",
                    "<cmd>lua require('config.lsp').server_capabilities()<cr>",
                    desc = "Get Capabilities",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>ld",
                    "<cmd>Telescope diagnostics bufnr=0<cr>",
                    desc = "Document Diagnostics",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lf",
                    "<cmd>lua require('config.lsp.handlers').lsp_format(0)<cr>",
                    desc = "Format",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lh",
                    "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
                    desc = "Toggle Inlay Hints",
                    nowait = true,
                    remap = false,
                },
                { "<leader>li", "<cmd>che lspconfig<cr>", desc = "Info", nowait = true, remap = false },
                {
                    "<leader>lm",
                    "<cmd>Telescope lsp_implementations<cr>",
                    desc = "Find Implementations",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lg",
                    "<cmd>Telescope lsp_definitions<cr>",
                    desc = "Find Definitions",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lj",
                    "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
                    desc = "Next Diagnostic",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lk",
                    "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
                    desc = "Prev Diagnostic",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>ll",
                    "<cmd>lua vim.lsp.codelens.run()<cr>",
                    desc = "CodeLens Action",
                    nowait = true,
                    remap = false,
                },
                { "<leader>ln", "<cmd>NullLsInfo<cr>", desc = "Null-ls Info", nowait = true, remap = false },
                {
                    "<leader>lr",
                    function()
                        return ":Rename " .. vim.fn.expand "<cword>"
                    end,
                    desc = "Rename",
                    expr = true,
                    nowait = true,
                    remap = false,
                    replace_keycodes = false,
                },
                {
                    "<leader>lR",
                    "<cmd>Telescope lsp_references initial_mode=normal<cr>",
                    desc = "Find Usage",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>ls",
                    "<cmd>Telescope lsp_document_symbols<cr>",
                    desc = "Document Symbols",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lv",
                    "<cmd>lua require('lsp_lines').toggle()<cr>",
                    desc = "Toggle Virtual Lines",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>lV",
                    function()
                        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                    end,
                    desc = "Toggle Diagnostics",
                    nowait = true,
                    remap = false,
                },
                { "<leader>n", group = "Neogen", nowait = true, remap = false },
                {
                    "<leader>nF",
                    "<cmd>lua require('neogen').generate({ type = 'file' })<CR>",
                    desc = "File",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>nc",
                    "<cmd>lua require('neogen').generate({ type = 'class' })<CR>",
                    desc = "Class",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>nf",
                    "<cmd>lua require('neogen').generate({ type = 'func' })<CR>",
                    desc = "Function",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>nt",
                    "<cmd>lua require('neogen').generate({ type = 'type' })<CR>",
                    desc = "Type",
                    nowait = true,
                    remap = false,
                },
                { "<leader>o", group = "Options", nowait = true, remap = false },
                {
                    "<leader>oC",
                    "<cmd>lua vim.g.cmp_active=true<cr>",
                    desc = "Completion on",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>oc",
                    "<cmd>lua vim.g.cmp_active=false<cr>",
                    desc = "Completion off",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>or",
                    '<cmd>lua require("config.functions").toggle_option("relativenumber")<cr>',
                    desc = "Relative",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>ow",
                    '<cmd>lua require("config.functions").toggle_option("wrap")<cr>',
                    desc = "Wrap",
                    nowait = true,
                    remap = false,
                },
                { "<leader>p", group = "Plugins", nowait = true, remap = false },
                { "<leader>pC", "<cmd>Lazy clear<cr>", desc = "Clear finished tasks", nowait = true, remap = false },
                { "<leader>pP", "<cmd>Lazy profile<cr>", desc = "Profile", nowait = true, remap = false },
                { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean", nowait = true, remap = false },
                { "<leader>pd", "<cmd>Lazy debug<cr>", desc = "Debug", nowait = true, remap = false },
                { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install", nowait = true, remap = false },
                { "<leader>pl", "<cmd>Lazy log<cr>", desc = "Log", nowait = true, remap = false },
                { "<leader>pp", "<cmd>Lazy home<cr>", desc = "Launch Lazy", nowait = true, remap = false },
                { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync", nowait = true, remap = false },
                { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true, remap = false },
                {
                    "<leader>q",
                    "<cmd>lua require('config.functions').smart_quit()<CR>",
                    desc = "Quit",
                    nowait = true,
                    remap = false,
                },
                { "<leader>r", group = "Replace", nowait = true, remap = false },
                {
                    "<leader>rf",
                    "<cmd>lua require('spectre').open_file_search()<cr>",
                    desc = "Replace Buffer",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>rr",
                    "<cmd>lua require('spectre').open()<cr>",
                    desc = "Replace",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>rw",
                    "<cmd>lua require('spectre').open_visual({select_word=true, is_insert_mode=false})<cr>",
                    desc = "Replace Word",
                    nowait = true,
                    remap = false,
                },
                { "<leader>t", group = "Test", nowait = true, remap = false },
                {
                    "<leader>tA",
                    function()
                        for _, adapter_id in ipairs(neotest.state.adapter_ids()) do
                            neotest.run.run { suite = true, adapter = adapter_id }
                        end
                    end,
                    desc = "Run Suite",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>tS",
                    "<cmd>lua require('neotest').run.stop()<cr>",
                    desc = "Stop Running Tests",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>ta",
                    "<cmd>lua require('neotest').run.attach()<cr>",
                    desc = "Attach To Nearest Test",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>tf",
                    "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
                    desc = "Run File",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>tn",
                    "<cmd>lua require('neotest').run.run()<cr>",
                    desc = "Run Nearest Test",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>to",
                    "<cmd>lua require('neotest').output.open()<cr>",
                    desc = "Open Output",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>tp",
                    "<cmd>lua require('neotest').output_panel.toggle()<cr>",
                    desc = "Toggle Output Panel",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>ts",
                    "<cmd>lua require('neotest').summary.toggle()<cr>",
                    desc = "Toggle Summary Window",
                    nowait = true,
                    remap = false,
                },
                { "<leader>tc", group = "Coverage", nowait = true, remap = false },
                {
                    "<leader>tcl",
                    "<cmd>lua require('coverage').load()<cr>",
                    desc = "Load Coverage",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>tct",
                    "<cmd>lua require('coverage').toggle()<cr>",
                    desc = "Toggle Coverage",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>tcs",
                    "<cmd>lua require('coverage').summary()<cr>",
                    desc = "Show Coverage Summary",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>u",
                    '<cmd>lua require("undotree").toggle()<cr>',
                    desc = "Undotree",
                    nowait = true,
                    remap = false,
                },
                { "<leader>w", "<cmd>w<CR>", desc = "Write", nowait = true, remap = false },
                { "<leader>zM", desc = "<cmd>lua require('ufo').closeAllFolds<CR>", nowait = true, remap = false },
                { "<leader>zR", desc = "<cmd>lua require('ufo').openAllFolds<CR>", nowait = true, remap = false },
                {
                    "<leader>x",
                    ":.lua<CR>",
                    desc = "Execute Lua code",
                    nowait = true,
                    remap = false,
                },
                {
                    "<leader>s",
                    "<cmd>source %<CR>",
                    desc = "Source file",
                    nowait = true,
                    remap = false,
                },
            }

            local vmappings = {
                {
                    mode = { "v" },
                    {
                        "<leader>/",
                        '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
                        desc = "Comment",
                        nowait = true,
                        remap = false,
                    },
                    { "<leader>l", group = "LSP", nowait = true, remap = false },
                    {
                        "<leader>la",
                        "<esc><cmd>lua vim.lsp.buf.code_action()<CR>",
                        desc = "Range Code Action",
                        nowait = true,
                        remap = false,
                    },
                    {
                        "<leader>x",
                        ":lua<CR>",
                        desc = "Execute Lua code",
                        nowait = true,
                        remap = false,
                    },
                },
            }

            which_key.setup(setup)
            which_key.add(mappings)
            which_key.add(vmappings)
        end,
    },
}
