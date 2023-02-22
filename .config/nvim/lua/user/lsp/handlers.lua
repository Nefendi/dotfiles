local M = {}

local icons = require "user.icons"
local functions = require "user.functions"

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false, -- disable virtual text
        virtual_lines = false,
        signs = {
            active = signs, -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end

local FORMAT_ON_SAVE_ON = true

M.lsp_format = function(bufnr)
    vim.lsp.buf.format {
        filter = function(client)
            -- This list is needed, because sometimes formatters provided by null-ls
            -- should be used instead of LSP formatting capabilities
            local servers_to_turn_off_formatting_capabilities =
                { "tsserver", "html", "jsonls", "clangd", "gopls", "csharp_ls" }

            return not functions.contains(servers_to_turn_off_formatting_capabilities, client.name)
        end,
        bufnr = bufnr,
        timeout_ms = 5000,
    }
end

local function lsp_format_on_save(bufnr)
    if FORMAT_ON_SAVE_ON then
        M.lsp_format(bufnr)
    end
end

local format_on_save_augroup = vim.api.nvim_create_augroup("FormatOnSave", {})

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = format_on_save_augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_on_save_augroup,
            buffer = bufnr,
            callback = function()
                lsp_format_on_save(bufnr)
            end,
        })
    end

    if client.name == "gopls" then
        vim.lsp.codelens.refresh()
    end

    if client.name == "jdt.ls" then
        vim.lsp.codelens.refresh()
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
        end
    end

    lsp_keymaps(bufnr)

    -- nvim-navic
    local status_navic_ok, navic = pcall(require, "nvim-navic")
    if not status_navic_ok then
        return
    end

    -- nvim-navic requires an LSP to support documentSymbol and old SymbolInformation format
    local not_supported_navic_servers = {
        "dockerls",
        "cssmodules_ls",
        "html",
        "eslint",
        "emmet_ls",
        "cssls",
        "bashls",
        "ltex",
        "golangci_lint_ls",
        "cmake",
        "null-ls",
    }

    if not functions.contains(not_supported_navic_servers, client.name) then
        navic.attach(client, bufnr)
    end
end

local function toggle_format_on_save()
    if not FORMAT_ON_SAVE_ON then
        FORMAT_ON_SAVE_ON = true
        vim.notify "Enabled format on save"
    else
        FORMAT_ON_SAVE_ON = false
        vim.notify "Disabled format on save"
    end
end

vim.api.nvim_create_user_command("LspToggleAutoFormat", toggle_format_on_save, {})

return M
