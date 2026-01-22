local M = {}

local icons = require "config.icons"
local functions = require "config.functions"

-- This list is needed, because sometimes formatters provided by null-ls
-- should be used instead of LSP formatting capabilities
local servers_to_turn_off_formatting_capabilities = { "ts_ls", "html", "jsonls", "csharp_ls" }

M.setup = function()
    local config = {
        virtual_text = false,
        virtual_lines = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
            },
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
end

local show_documentation = function()
    local filetype = vim.bo.filetype

    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
    elseif vim.fn.expand "%:t" == "Cargo.toml" then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end

local lsp_keymaps = function(bufnr)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics" })
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show signature help" })
    vim.keymap.set({ "i", "s" }, "<C-S>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show signature help" })
    vim.keymap.set("n", "K", show_documentation, { buffer = bufnr, desc = "Show documentation" })
end

vim.g.format_on_save_enabled = true

M.lsp_format = function(bufnr, client_id)
    vim.lsp.buf.format {
        bufnr = bufnr,
        id = client_id,
        timeout_ms = 5000,
    }
end

local blink_cmp = require "blink.cmp"

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = blink_cmp.get_lsp_capabilities(M.capabilities)
M.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

M.on_attach = function(client, bufnr)
    if
        not functions.contains(servers_to_turn_off_formatting_capabilities, client.name)
            and not client.supports_method "textDocument/willSaveWaitUntil"
            and client.supports_method "textDocument/formatting"
        -- For some reason lemminx does not support textDocument/formatting but it can format
        or client.name == "lemminx"
    then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("lsp_auto_formatting", { clear = false }),
            buffer = bufnr,
            callback = function()
                if vim.g.format_on_save_enabled then
                    M.lsp_format(bufnr, client.id)
                end
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

    local navic = require "nvim-navic"

    if client.server_capabilities.documentSymbolProvider then
        if client.name == "templ" then
            return
        end

        navic.attach(client, bufnr)
    end
end

return M
