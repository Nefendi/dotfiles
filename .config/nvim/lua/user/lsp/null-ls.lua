local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
    on_attach = require("user.lsp.handlers").on_attach,
    debug = false,
    sources = {
        -- Miscellaneous
        -- Prettier only for markdown because I don't know how to set --prose-wrap in prettierd here
        formatting.prettier.with {
            filetypes = { "markdown" },
            extra_args = { "--prose-wrap", "always" },
        },
        formatting.prettierd.with {
            disabled_filetypes = { "markdown" },
        },
        diagnostics.actionlint,

        -- Python
        formatting.black,
        formatting.isort,
        diagnostics.flake8,
        diagnostics.pylint,
        -- NOTE: It is handy in projects with nested configuration files
        -- diagnostics.pylint.with {
        --     cwd = function(_)
        --         -- return params.root:match ".null-ls-root"
        --         -- return params.root:match ".git"
        --         return nil
        --     end,
        -- },
        diagnostics.mypy,

        -- Lua
        formatting.stylua,

        -- Go
        formatting.golines,
        formatting.gofumpt,

        -- C#
        formatting.csharpier,

        -- Bash
        formatting.shfmt.with {
            filetypes = { "sh", "zsh" },
        },

        -- Dockerfile
        diagnostics.hadolint,

        -- C++
        formatting.clang_format.with {
            filetypes = { "c", "cpp", "cuda" },
        },

        -- Haskell
        formatting.fourmolu,

        -- Markdown
        diagnostics.markdownlint,

        -- YAML
        diagnostics.yamllint,

        -- XML
        formatting.xmlformat,

        -- Git
        diagnostics.gitlint.with {
            extra_args = { "-c", "title-max-length.line-length=50", "-c", "body-max-line-length.line-length=72" },
        },

        -- LaTeX
        formatting.latexindent,
    },
}
