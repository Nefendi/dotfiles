local M = {}

local icons = require "config.icons"
local functions = require "config.functions"

-- This list is needed, because sometimes formatters provided by null-ls
-- should be used instead of LSP formatting capabilities
local servers_to_turn_off_formatting_capabilities = { "ts_ls", "html", "jsonls", "csharp_ls" }

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

M.lsp_format = function(bufnr, client_id)
    vim.lsp.buf.format {
        filter = function(client)
            return not functions.contains(servers_to_turn_off_formatting_capabilities, client.name)
        end,
        bufnr = bufnr,
        id = client_id,
        timeout_ms = 5000,
    }
end

local function lsp_format_on_save(bufnr, client_id)
    if FORMAT_ON_SAVE_ON then
        M.lsp_format(bufnr, client_id)
    end
end

local blink_cmp = require "blink.cmp"

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = blink_cmp.get_lsp_capabilities(M.capabilities)
M.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

M.on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                lsp_format_on_save(bufnr, client.id)
            end,
        })
    end

    if client.supports_method "textDocument/codeLens" then
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            callback = function()
                vim.lsp.codelens.refresh { bufnr = bufnr }
            end,
        })
    end

    if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(true)
    end

    if client.name == "jdt.ls" then
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
        end
    end

    if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
    end

    lsp_keymaps(bufnr)

    -- nvim-navic
    local status_navic_ok, navic = pcall(require, "nvim-navic")
    if not status_navic_ok then
        return
    end

    if client.server_capabilities.documentSymbolProvider then
        if client.name == "templ" then
            return
        end

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
