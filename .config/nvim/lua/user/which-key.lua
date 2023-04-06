local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local icons = require "user.icons"

local setup = {
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
            text_objects = false, -- help for text objects triggered after entering an operator
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
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = false, -- show help message on the command line when the popup is visible
    key_labels = {
        ["<leader>"] = "SPC",
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    b = {
        "<cmd>Telescope buffers<cr>",
        "Buffers",
    },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    w = { "<cmd>w<CR>", "Write" },
    a = { "<cmd>wa<CR>", "Write All" },
    h = { "<cmd>nohlsearch<CR>", "No HL" },
    q = { "<cmd>lua require('user.functions').smart_quit()<CR>", "Quit" },
    ["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
    c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    P = { "<cmd>Telescope projects<cr>", "Projects" },
    [" "] = {
        "<cmd>Telescope find_files<cr>",
        "Find Files",
    },
    u = { '<cmd>lua require("undotree").toggle()<cr>', "Undotree" },

    p = {
        name = "Plugins",
        i = { "<cmd>Lazy install<cr>", "Install" },
        s = { "<cmd>Lazy sync<cr>", "Sync" },
        C = { "<cmd>Lazy clear<cr>", "Clear finished tasks" },
        c = { "<cmd>Lazy clean<cr>", "Clean" },
        u = { "<cmd>Lazy update<cr>", "Update" },
        p = { "<cmd>Lazy profile<cr>", "Profile" },
        l = { "<cmd>Lazy log<cr>", "Log" },
        L = { "<cmd>Lazy home<cr>", "Launch Lazy" },
        d = { "<cmd>Lazy debug<cr>", "Debug" },
    },

    o = {
        name = "Options",
        w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
        r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
        c = { "<cmd>lua vim.g.cmp_active=false<cr>", "Completion off" },
        C = { "<cmd>lua vim.g.cmp_active=true<cr>", "Completion on" },
        -- l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
        -- s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
        -- t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
    },

    r = {
        name = "Replace",
        r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        w = {
            "<cmd>lua require('spectre').open_visual({select_word=true, is_insert_mode=false})<cr>",
            "Replace Word",
        },
        f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
    },

    d = {
        name = "Debug",
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
        O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
        l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
        u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
    },

    f = {
        name = "Find",
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = {
            "<cmd>Telescope find_files<cr>",
            "Find Files",
        },
        t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        T = { "<cmd>Telescope grep_string<cr>", "Find Current Word" },
        i = { "<cmd>Telescope media_files<cr>", "Media" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        H = { "<cmd>Telescope highlights<cr>", "Highlights" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        n = { "<cmd>Telescope notify initial_mode=normal<cr>", "Find Notifications" },
        s = { "<cmd>TodoTelescope initial_mode=normal<cr>", "TODO comments" },
    },

    g = {
        name = "Git",
        g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        l = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Blame" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
        c = {
            name = "+Conflicts",
            o = { "<cmd>GitConflictChooseOurs<cr>", "Accept Current Changes" },
            t = { "<cmd>GitConflictChooseTheirs<cr>", "Accept Incoming Changes" },
            b = { "<cmd>GitConflictChooseBoth<cr>", "Accept Both Changes" },
            N = { "<cmd>GitConflictChooseNone<cr>", "Reject Both Changes" },
            n = { "<cmd>GitConflictNextConflict<cr>", "Next Conflict" },
            p = { "<cmd>GitConflictPrevConflict<cr>", "Previous Conflict" },
            f = { "<cmd>GitConflictListQf<cr>", "Show Conflicts" },
        },
        -- j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        -- k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        -- p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        -- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        -- R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        -- u = {
        -- 	"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        -- 	"Undo Stage Hunk",
        -- },
        -- o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        -- c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        -- d = {
        -- 	"<cmd>Gitsigns diffthis HEAD<cr>",
        -- 	"Diff",
        -- },
    },

    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
        d = {
            "<cmd>Telescope diagnostics bufnr=0<cr>",
            "Document Diagnostics",
        },
        D = {
            "<cmd>Telescope diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua require('user.lsp.handlers').lsp_format(0)<cr>", "Format" },
        F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Installer Info" },
        n = { "<cmd>NullLsInfo<cr>", "Null-ls Info" },
        j = {
            "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
            "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        -- q = { "<cmd>lua vim.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
        v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle Virtual Lines" },
        h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Inlay Hints" },
        H = { "<cmd>lua require('lsp-inlayhints').reset()<cr>", "Clear Inlay Hints" },
    },

    t = {
        name = "Test",
        -- s = { "<cmd>TestSuite<cr>", "Run Suite" },
        -- f = { "<cmd>TestFile<cr>", "Run File" },
        -- e = { "<cmd>TestEdit<cr>", "Edit Test File" },
        -- n = { "<cmd>TestNearest<cr>", "Run Nearest Test" },
        -- l = { "<cmd>TestLast<cr>", "Rerun Latest Test" },
        -- v = { "<cmd>TestVisit<cr>", "Last Running Test" },
        -- i = { "<cmd>TestInfo<cr>", "Test Info" },
        f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
        n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest Test" },
        a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach To Nearest Test" },
        S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop Running Tests" },
        s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Toggle Summary Window" },
        p = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", "Toggle Output Panel" },
        o = { "<cmd>lua require('neotest').output.open()<cr>", "Open Output" },
    },

    T = {
        name = "Treesitter",
        h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
        p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
        r = { "<cmd>TSToggle rainbow<cr>", "Toggle Rainbow" },
    },

    j = {
        name = "Lab",
        r = { "<cmd>Lab code run<cr>", "Run" },
        s = { "<cmd>Lab code stop<cr>", "Stop" },
        p = { "<cmd>Lab code panel<cr>", "Open Panel" },
        c = { "<cmd>Lab code config<cr>", "Config" },
    },

    n = {
        name = "Neogen",
        f = { "<cmd>lua require('neogen').generate({ type = 'func' })<CR>", "Function" },
        c = { "<cmd>lua require('neogen').generate({ type = 'class' })<CR>", "Class" },
        t = { "<cmd>lua require('neogen').generate({ type = 'type' })<CR>", "Type" },
        F = { "<cmd>lua require('neogen').generate({ type = 'file' })<CR>", "File" },
    },
    z = {
        R = { "<cmd>lua require('ufo').openAllFolds<CR>" },
        M = { "<cmd>lua require('ufo').closeAllFolds<CR>" },
    },
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
    ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', "Comment" },
    l = {
        name = "LSP",
        a = {
            "<esc><cmd>lua vim.lsp.buf.code_action()<CR>",
            "Range Code Action",
        },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
