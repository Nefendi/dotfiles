local icons = require "config.icons"
local functions = require "config.functions"

local servers = {
    "cssls",
    "cssmodules_ls",
    "html",
    "jsonls",
    "lua_ls",
    "ts_ls",
    "basedpyright",
    "yamlls",
    "bashls",
    "dockerls",
    -- "cmake",
    "taplo",
    "clangd",
    "ltex",
    "texlab",
    "marksman",
    "gopls",
    "templ",
    "golangci_lint_ls",
    "rust_analyzer",
    "emmet_language_server",
    "eslint",
    "tailwindcss",
    "lemminx",
    "ruff",
    "elixirls",
    "zls",
    "ansiblels",
    "helm_ls",
    "gh_actions_ls",
}

-- TODO: Maybe someday linters and formatters could be automatically installed by Mason itself?
local linters = {
    "hadolint",
    "shellcheck",
    "markdownlint",
    "yamllint",
    "gitlint",
    "actionlint",
    "buf",
    "golangci-lint",
    "mypy",
    "ansible-lint",
    "kube-linter",
}

local formatters = {
    "stylua",
    "golines",
    "goimports",
    "shfmt",
    "clang-format",
    "prettier",
    "prettierd",
    "google-java-format",
}

local debuggers = {
    "debugpy",
    "delve",
    "codelldb",
}

local other = {
    "gomodifytags",
    "gotests",
    "impl",
    "iferr",
}

local tools_to_install = {}

vim.list_extend(tools_to_install, linters)
vim.list_extend(tools_to_install, formatters)
vim.list_extend(tools_to_install, debuggers)
vim.list_extend(tools_to_install, other)

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = icons.ui.Check,
            package_pending = icons.kind.Property,
            package_uninstalled = icons.ui.Planet,
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    PATH = "append",
}

local mason = require "mason"

local mason_lspconfig = require "mason-lspconfig"

local mason_tool_installer = require "mason-tool-installer"

mason.setup(settings)

mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = false,
    automatic_enable = false,
}

mason_tool_installer.setup {
    ensure_installed = tools_to_install,
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
}

-- Remove default LSP keybindings
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gO")
vim.keymap.del({ "i", "s" }, "<C-S>")

vim.lsp.config("*", {
    capabilities = require("config.lsp.handlers").capabilities,
})

local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_cmds,
    desc = "Global on_attach behaviour",
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        require("config.lsp.handlers").on_attach(client, bufnr)
    end,
})

for _, server in ipairs(servers) do
    -- Remove version
    server = server:gsub("@.*$", "")

    -- Skip enabling of particular servers
    if functions.contains({ "jdtls", "rust_analyzer" }, server) then
        goto continue
    end

    vim.lsp.enable(server)

    ::continue::
end
