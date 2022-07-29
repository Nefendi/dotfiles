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
    "marksman",
    "gopls",
    "rust_analyzer",
    "emmet_ls",
    "eslint",
    "hls",
}

-- TODO: Maybe someday linters and formatters could be automatically installed by Mason itself?
local linters = {
    "hadolint",
    "cspell",
    "golangci-lint",
    "shellcheck",
    "markdownlint",
    "yamllint",
    "gitlint",
    "actionlint",
}

local formatters = {
    "stylua",
    "gofumpt",
    "golines",
    "shfmt",
    "clang-format",
}

local tools_to_install = {}

-- vim.list_extend(tools_to_install, servers)
vim.list_extend(tools_to_install, linters)
vim.list_extend(tools_to_install, formatters)

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    return
end

local mason_tool_installer_status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if not mason_tool_installer_status_ok then
    return
end

mason.setup(settings)

mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = false,
}

mason_tool_installer.setup {
    ensure_installed = tools_to_install,
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
}

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
        local l_status_ok, lua_dev = pcall(require, "lua-dev")

        if not l_status_ok then
            return
        end

        local luadev = lua_dev.setup {
            lspconfig = {
                on_attach = opts.on_attach,
                capabilities = opts.capabilities,
            },
        }

        lspconfig.sumneko_lua.setup(luadev)

        goto continue
    end

    if server == "pyright" then
        local pyright_opts = require "user.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "ltex" then
        local ltex_opts = require "user.lsp.settings.ltex"
        opts = vim.tbl_deep_extend("force", ltex_opts, opts)
    end

    if server == "clangd" then
        local clangd_opts = require "user.lsp.settings.clangd"
        opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end

    if server == "emmet_ls" then
        local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
        opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
    end

    if server == "rust_analyzer" then
        local rust_opts = require "user.lsp.settings.rust"

        local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
        if not rust_tools_status_ok then
            return
        end

        rust_tools.setup(rust_opts)

        goto continue
    end

    if server == "tsserver" then
        local tsserver_opts = require "user.lsp.settings.tsserver"
        opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    if server == "gopls" then
        local gopls_opts = require "user.lsp.settings.gopls"
        opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    lspconfig[server].setup(opts)

    ::continue::
end
