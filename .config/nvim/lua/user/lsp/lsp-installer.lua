local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"cssls",
	"cssmodules_ls",
	"html",
	"jsonls",
	"sumneko_lua",
	"tsserver",
	"pyright",
	"yamlls",
	"bashls",
	"dockerls",
	"cmake",
	"taplo",
	"clangd",
	"ltex",
	"remark_ls",
	"gopls",
	"rust_analyzer",
	"emmet_ls",
	"eslint",
	"hls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "ltex" then
		local ltex_opts = require("user.lsp.settings.ltex")
		opts = vim.tbl_deep_extend("force", ltex_opts, opts)
	end

	if server == "clangd" then
		local clangd_opts = require("user.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
	end

	if server == "emmet_ls" then
		local emmet_ls_opts = require("user.lsp.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end

    -- Source: https://github.com/LunarVim/nvim-basic-ide/tree/rust-ide-0.7
    if server == "rust_analyzer" then
        local keymap = vim.keymap.set
        local key_opts = { silent = true }

        keymap("n", "<leader>Rh", "<cmd>RustToggleInlayHints<Cr>", key_opts)
        keymap("n", "<leader>Rr", "<cmd>RustRunnables<Cr>", key_opts)
        keymap("n", "<leader>Re", "<cmd>RustExpandMacro<Cr>", key_opts)
        keymap("n", "<leader>Rc", "<cmd>RustOpenCargo<Cr>", key_opts)
        keymap("n", "<leader>Rp", "<cmd>RustParentModule<Cr>", key_opts)
        keymap("n", "<leader>Rg", "<cmd>RustViewCrateGraph<Cr>", key_opts)
        keymap("n", "<leader>Rw", "<cmd>RustReloadWorkspace<Cr>", key_opts)

        require("rust-tools").setup {
          tools = {
            on_initialized = function()
              vim.cmd [[
                autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
              ]]
            end,
          },
          server = {
            on_attach = require("user.lsp.handlers").on_attach,
            capabilities = require("user.lsp.handlers").capabilities,
            settings = {
              ["rust-analyzer"] = {
                lens = {
                  enable = true,
                },
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          },
        }

        goto continue
  end

	lspconfig[server].setup(opts)

    ::continue::
end
