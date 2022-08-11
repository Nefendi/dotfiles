local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
    debug = false,
    sources = {
        -- Miscellaneous
        formatting.prettier.with {
            extra_filetypes = { "toml" },
            extra_args = { "--prose-wrap", "always" },
        },
        diagnostics.actionlint,


        -- Python
        formatting.black,
        formatting.isort,
        diagnostics.flake8,
        diagnostics.pylint,
        diagnostics.mypy,

        -- Lua
        formatting.stylua,

        -- Go
        formatting.golines,
        formatting.gofumpt,
        diagnostics.golangci_lint.with {
            timeout = 10000,
            args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
        },

        -- Bash
        formatting.shfmt,
        diagnostics.shellcheck.with {
            extra_args = { "--severity", "warning" },
        },

        -- Dockerfile
        diagnostics.hadolint,

        -- LaTeX
        formatting.latexindent,

        -- C++
        formatting.clang_format.with {
            filetypes = { "c", "cpp", "cuda" },
        },

        -- Markdown
        diagnostics.markdownlint,

        -- YAML
        diagnostics.yamllint,

        -- Git
        diagnostics.gitlint.with {
            extra_args = { "-c", "title-max-length.line-length=50", "-c", "body-max-line-length.line-length=72" },
        },
    },
}
