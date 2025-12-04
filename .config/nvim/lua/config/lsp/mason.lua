local icons = require "config.icons"

local servers = {
    "cssls",
    "cssmodules_ls",
    "html",
    "jsonls",
    "lua_ls",
    "ts_ls",
    -- "pyright",
    "basedpyright",
    -- "pylyzer",
    "yamlls",
    "bashls",
    "dockerls",
    "cmake",
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
    -- "jdtls",
    -- "csharp_ls",
    -- "hls",
    "tailwindcss",
    "lemminx",
    -- "phpactor",
    -- "solargraph",
    "ruff",
    "elixirls",
    "zls",
    "ansiblels",
    "helm_ls",
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
}

local formatters = {
    "stylua",
    "golines",
    "goimports",
    "shfmt",
    "clang-format",
    "prettier",
    "prettierd",
    -- "csharpier",
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

-- vim.list_extend(tools_to_install, servers)
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

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("config.lsp.handlers").on_attach,
        capabilities = require("config.lsp.handlers").capabilities,
    }

    if server == "jsonls" then
        local jsonls_opts = require "config.lsp.settings.jsonls"
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server == "yamlls" then
        local yamlls_opts = require "config.lsp.settings.yamlls"
        opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    if server == "lua_ls" then
        local lua_ls_opts = require "config.lsp.settings.lua_ls"
        opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require "config.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "basedpyright" then
        local basedpyright_opts = require "config.lsp.settings.basedpyright"
        opts = vim.tbl_deep_extend("force", basedpyright_opts, opts)
    end

    -- TODO: Get pylyzer to work (right now it works only in the shell)
    if server == "pylyzer" then
        goto continue
    end

    if server == "ltex" then
        local ltex_opts = require "config.lsp.settings.ltex"
        opts = vim.tbl_deep_extend("force", ltex_opts, opts)
    end

    if server == "texlab" then
        local texlab_opts = require "config.lsp.settings.texlab"
        opts = vim.tbl_deep_extend("force", texlab_opts, opts)
    end

    if server == "clangd" then
        local clangd_opts = require "config.lsp.settings.clangd"
        opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end

    if server == "rust_analyzer" then
        vim.g.rustaceanvim = require "config.lsp.settings.rust"
        goto continue
    end

    if server == "ts_ls" then
        local tsserver_opts = require "config.lsp.settings.tsserver"
        opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    if server == "emmet_language_server" then
        local emmet_language_server_opts = require "config.lsp.settings.emmet_language_server"
        opts = vim.tbl_deep_extend("force", emmet_language_server_opts, opts)
    end

    if server == "gopls" then
        local gopls_opts = require "config.lsp.settings.gopls"
        opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    if server == "golangci_lint_ls" then
        local golangci_lint_ls_opts = require "config.lsp.settings.golangci_lint_ls"
        opts = vim.tbl_deep_extend("force", golangci_lint_ls_opts, opts)
    end

    if server == "jdtls" then
        goto continue
    end

    if server == "bashls" then
        local bashls_opts = require "config.lsp.settings.bashls"
        opts = vim.tbl_deep_extend("force", bashls_opts, opts)
    end

    if server == "ruff" then
        local ruff_opts = require "config.lsp.settings.ruff"
        opts = vim.tbl_deep_extend("force", ruff_opts, opts)
    end

    if server == "solargraph" then
        local solargraph_opts = require "config.lsp.settings.solargraph"
        opts = vim.tbl_deep_extend("force", solargraph_opts, opts)
    end

    if server == "elixirls" then
        local elixirls_opts = require "config.lsp.settings.elixirls"
        opts = vim.tbl_deep_extend("force", elixirls_opts, opts)
    end

    if server == "zls" then
        local zls_opts = require "config.lsp.settings.zls"
        opts = vim.tbl_deep_extend("force", zls_opts, opts)
    end

    if server == "ansiblels" then
        local ansiblels_opts = require "config.lsp.settings.ansiblels"
        opts = vim.tbl_deep_extend("force", ansiblels_opts, opts)
    end

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)

    ::continue::
end
