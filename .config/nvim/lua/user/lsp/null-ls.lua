local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local mason_path = vim.fn.stdpath("data") .. "/mason/bin/"

null_ls.setup({
	debug = false,
	sources = {
		-- Miscellaneous
		formatting.prettier.with({
			cmd = mason_path .. "prettier",
			extra_filetypes = { "toml" },
		}),

		-- Python
		formatting.black,
		formatting.isort,
		diagnostics.flake8,
		diagnostics.pylint,
		diagnostics.mypy,

		-- Lua
		formatting.stylua.with({
			cmd = mason_path .. "stylua",
		}),

		-- Go
		formatting.golines.with({
			cmd = mason_path .. "golines",
		}),
		formatting.gofumpt.with({
			cmd = mason_path .. "gofumpt",
		}),
		diagnostics.golangci_lint.with({
			cmd = mason_path .. "golangci-lint",
			timeout = 10000,
			args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
		}),

		-- Bash
		formatting.shfmt.with({
			cmd = mason_path .. "shfmt",
		}),
		diagnostics.shellcheck.with({
			cmd = mason_path .. "shellcheck",
			extra_args = { "--severity", "warning" },
		}),

		-- Dockerfile
		diagnostics.hadolint.with({
			cmd = mason_path .. "hadolint",
		}),

		-- LaTeX
		formatting.latexindent,

		-- C++
		formatting.clang_format,

		-- Markdown
		diagnostics.markdownlint.with({
			cmd = mason_path .. "markdownlint",
		}),
	},
})
