return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            win = {
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                wo = {
                    winblend = 0,
                },
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
            },
        },

        config = function(_, opts)
            local which_key = require "which-key"

            local neotest = require "neotest"

            local mappings = {
                { "<leader>T", group = "Treesitter", nowait = true },
                { "<leader>Tc", "<cmd>TSContext toggle<cr>", desc = "Toggle Context", nowait = true },
                { "<leader>Ti", "<cmd>Inspect<cr>", desc = "Inspect", nowait = true },
                { "<leader>Tt", "<cmd>InspectTree<cr>", desc = "Inspect Tree", nowait = true },
                {
                    "<leader>Tr",
                    function()
                        require("rainbow-delimiters").toggle(0)
                    end,
                    desc = "Toggle Rainbow",
                    nowait = true,
                },
                { "<leader>W", "<cmd>wa<CR>", desc = "Write All", nowait = true },
                { "<leader>c", "<cmd>lua Snacks.bufdelete()<CR>", desc = "Close Buffer", nowait = true },
                { "<leader>d", group = "Debug", nowait = true },
                { "<leader>a", group = "AI", nowait = true },
                { "<leader>m", group = "Mermaid", nowait = true },
                {
                    "<leader>dC",
                    function()
                        local condition = vim.fn.input "Condition: "
                        require("dap").set_breakpoint(condition)
                    end,
                    desc = "Conditional Breakpoint",
                    nowait = true,
                },
                {
                    "<leader>dg",
                    function()
                        local log_message = vim.fn.input "Log message: "
                        require("dap").set_breakpoint(nil, nil, log_message)
                    end,
                    desc = "Logpoint",
                    nowait = true,
                },
                {
                    "<leader>dX",
                    "<cmd>lua require'dap'.clear_breakpoints()<cr>",
                    desc = "Clear Breakpoints",
                    nowait = true,
                },
                {
                    "<leader>dL",
                    function()
                        require("dap").list_breakpoints()
                        vim.cmd "copen"
                    end,
                    desc = "List Breakpoints",
                    nowait = true,
                },
                { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Out", nowait = true },
                {
                    "<leader>dR",
                    "<cmd>lua require'dap'.repl.toggle()<cr>",
                    desc = "Repl",
                    nowait = true,
                },
                {
                    "<leader>db",
                    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
                    desc = "Breakpoint",
                    nowait = true,
                },
                {
                    "<leader>dc",
                    "<cmd>lua require'dap'.continue()<cr>",
                    desc = "Continue",
                    nowait = true,
                },
                { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Into", nowait = true },
                { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Last", nowait = true },
                { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Over", nowait = true },
                { "<leader>dr", "<cmd>lua require'dap'.restart()<cr>", desc = "Restart", nowait = true },
                { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "UI", nowait = true },
                { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Exit", nowait = true },
                {
                    "<leader>de",
                    "<cmd>lua require'dapui'.eval()<cr>",
                    desc = "Evaluate expression",
                    nowait = true,
                },
                { "<leader>f", desc = "Find" },
                { "<leader>g", group = "Git", nowait = true },
                {
                    "<leader>gL",
                    "<cmd>Gitsigns toggle_current_line_blame<cr>",
                    desc = "Toggle Blame",
                    nowait = true,
                },
                {
                    "<leader>gh",
                    "<cmd>Gitsigns toggle_linehl<cr>",
                    desc = "Toggle Line Highlights",
                    nowait = true,
                },
                { "<leader>gc", group = "Conflicts", nowait = true },
                {
                    "<leader>gcb",
                    "<cmd>GitConflictChooseBoth<cr>",
                    desc = "Accept Both Changes",
                    nowait = true,
                },
                {
                    "<leader>gcc",
                    "<cmd>GitConflictChooseOurs<cr>",
                    desc = "Accept Current Changes",
                    nowait = true,
                },
                {
                    "<leader>gci",
                    "<cmd>GitConflictChooseTheirs<cr>",
                    desc = "Accept Incoming Changes",
                    nowait = true,
                },
                {
                    "<leader>gcn",
                    "<cmd>GitConflictNextConflict<cr>",
                    desc = "Next Conflict",
                    nowait = true,
                },
                {
                    "<leader>gcp",
                    "<cmd>GitConflictPrevConflict<cr>",
                    desc = "Previous Conflict",
                    nowait = true,
                },
                {
                    "<leader>gcr",
                    "<cmd>GitConflictChooseNone<cr>",
                    desc = "Reject Both Changes",
                    nowait = true,
                },
                { "<leader>gcs", "<cmd>GitConflictListQf<cr>", desc = "Show Conflicts", nowait = true },
                { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff", nowait = true },
                {
                    "<leader>gD",
                    "<cmd>Gitsigns toggle_word_diff<cr>",
                    desc = "Word Diff",
                    nowait = true,
                },
                { "<leader>gl", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line", nowait = true },
                { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk", nowait = true },
                { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No HL", nowait = true },
                { "<leader>l", group = "LSP", nowait = true },
                { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Installer Info", nowait = true },
                {
                    "<leader>la",
                    "<cmd>lua vim.lsp.buf.code_action()<cr>",
                    desc = "Code Action",
                    nowait = true,
                },
                {
                    "<leader>lc",
                    "<cmd>lua require('config.lsp').server_capabilities()<cr>",
                    desc = "Get Capabilities",
                    nowait = true,
                },
                {
                    "<leader>lf",
                    "<cmd>lua require('config.lsp.handlers').lsp_format(0)<cr>",
                    desc = "Format",
                    nowait = true,
                },
                { "<leader>li", "<cmd>che vim.lsp<cr>", desc = "Info", nowait = true },
                {
                    "<leader>lj",
                    "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
                    desc = "Next Diagnostic",
                    nowait = true,
                },
                {
                    "<leader>lk",
                    "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
                    desc = "Prev Diagnostic",
                    nowait = true,
                },
                {
                    "<leader>ll",
                    "<cmd>lua vim.lsp.codelens.run()<cr>",
                    desc = "CodeLens Action",
                    nowait = true,
                },
                { "<leader>ln", "<cmd>NullLsInfo<cr>", desc = "Null-ls Info", nowait = true },
                {
                    "<leader>lr",
                    function()
                        local inc_rename = require "inc_rename"
                        return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand "<cword>"
                    end,
                    desc = "Rename",
                    expr = true,
                },
                { "<leader>G", group = "Neogen", nowait = true },
                {
                    "<leader>GF",
                    "<cmd>lua require('neogen').generate({ type = 'file' })<CR>",
                    desc = "File",
                    nowait = true,
                },
                {
                    "<leader>Gc",
                    "<cmd>lua require('neogen').generate({ type = 'class' })<CR>",
                    desc = "Class",
                    nowait = true,
                },
                {
                    "<leader>Gf",
                    "<cmd>lua require('neogen').generate({ type = 'func' })<CR>",
                    desc = "Function",
                    nowait = true,
                },
                {
                    "<leader>Gt",
                    "<cmd>lua require('neogen').generate({ type = 'type' })<CR>",
                    desc = "Type",
                    nowait = true,
                },
                { "<leader>o", group = "Options", nowait = true },
                { "<leader>A", group = "AI", nowait = true },
                { "<leader>p", group = "Plugins", nowait = true },
                { "<leader>pC", "<cmd>Lazy clear<cr>", desc = "Clear finished tasks", nowait = true },
                { "<leader>pP", "<cmd>Lazy profile<cr>", desc = "Profile", nowait = true },
                { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean", nowait = true },
                { "<leader>pd", "<cmd>Lazy debug<cr>", desc = "Debug", nowait = true },
                { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install", nowait = true },
                { "<leader>pl", "<cmd>Lazy log<cr>", desc = "Log", nowait = true },
                { "<leader>pp", "<cmd>Lazy home<cr>", desc = "Launch Lazy", nowait = true },
                { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync", nowait = true },
                { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true },
                {
                    "<leader>q",
                    "<cmd>lua require('config.functions').smart_quit()<CR>",
                    desc = "Quit",
                    nowait = true,
                },
                { "<leader>t", group = "Test", nowait = true },
                {
                    "<leader>tA",
                    function()
                        for _, adapter_id in ipairs(neotest.state.adapter_ids()) do
                            neotest.run.run { suite = true, adapter = adapter_id }
                        end
                    end,
                    desc = "Run Suite",
                    nowait = true,
                },
                {
                    "<leader>tS",
                    "<cmd>lua require('neotest').run.stop()<cr>",
                    desc = "Stop Running Tests",
                    nowait = true,
                },
                {
                    "<leader>ta",
                    "<cmd>lua require('neotest').run.attach()<cr>",
                    desc = "Attach To Nearest Test",
                    nowait = true,
                },
                {
                    "<leader>tf",
                    "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
                    desc = "Run File",
                    nowait = true,
                },
                {
                    "<leader>tn",
                    "<cmd>lua require('neotest').run.run()<cr>",
                    desc = "Run Nearest Test",
                    nowait = true,
                },
                {
                    "<leader>to",
                    "<cmd>lua require('neotest').output.open()<cr>",
                    desc = "Open Output",
                    nowait = true,
                },
                {
                    "<leader>tp",
                    "<cmd>lua require('neotest').output_panel.toggle()<cr>",
                    desc = "Toggle Output Panel",
                    nowait = true,
                },
                {
                    "<leader>ts",
                    "<cmd>lua require('neotest').summary.toggle()<cr>",
                    desc = "Toggle Summary Window",
                    nowait = true,
                },
                { "<leader>tc", group = "Coverage", nowait = true },
                {
                    "<leader>tcl",
                    "<cmd>lua require('coverage').load()<cr>",
                    desc = "Load Coverage",
                    nowait = true,
                },
                {
                    "<leader>tct",
                    "<cmd>lua require('coverage').toggle()<cr>",
                    desc = "Toggle Coverage",
                    nowait = true,
                },
                {
                    "<leader>tcs",
                    "<cmd>lua require('coverage').summary()<cr>",
                    desc = "Show Coverage Summary",
                    nowait = true,
                },
                { "<leader>w", "<cmd>w<CR>", desc = "Write", nowait = true },
                {
                    "<leader>x",
                    ":.lua<CR>",
                    desc = "Execute Lua code",
                    nowait = true,
                },
                {
                    "<leader>X",
                    "<cmd>source %<CR>",
                    desc = "Source file",
                    nowait = true,
                },
            }

            local vmappings = {
                {
                    { "<leader>l", group = "LSP", nowait = true },
                    {
                        "<leader>la",
                        "<esc><cmd>lua vim.lsp.buf.code_action()<CR>",
                        desc = "Range Code Action",
                        nowait = true,
                    },
                    {
                        "<leader>x",
                        ":lua<CR>",
                        desc = "Execute Lua code",
                        nowait = true,
                    },
                },
            }

            which_key.setup(opts)
            which_key.add(mappings)
            which_key.add(vmappings)
        end,
    },
}
