local M = {}

local formatting_timeout_ms = 5000

local icons = require("user.icons")

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
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(
		bufnr,
		"n",
		"<leader>lf",
		string.format("<cmd>lua vim.lsp.buf.formatting_sync(nil, %i)<cr>", formatting_timeout_ms),
		opts
	)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>ln", "<cmd>NullLsInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not status_cmp_ok then
		return
	end

	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "remark_ls" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "gopls" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "taplo" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "html" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "jsonls" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "clangd" then
		client.resolved_capabilities.document_formatting = false
	end

	M.capabilities = vim.lsp.protocol.make_client_capabilities()
	M.capabilities.textDocument.completion.completionItem.snippetSupport = true
	M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

function M.enable_format_on_save(notify)
	notify = notify or false

	vim.cmd([[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, formatting_timeout_ms)
    augroup end
  ]])

	if notify then
		vim.notify("Enabled format on save")
	end
end

function M.remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

function M.disable_format_on_save()
	M.remove_augroup("format_on_save")
	vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
		M.enable_format_on_save(true)
	else
		M.disable_format_on_save()
	end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]])

-- Enable format on save by default
M.enable_format_on_save(false)

return M
