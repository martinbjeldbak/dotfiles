local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.code_actions.xo,

        null_ls.builtins.completion.luasnip,
        null_ls.builtins.completion.spell,

        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.chktex,
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.erb_lint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.jshint,
        null_ls.builtins.diagnostics.jsonlint,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.proselint,
        null_ls.builtins.diagnostics.protoc_gen_lint,
        null_ls.builtins.diagnostics.protolint,
        null_ls.builtins.diagnostics.pycodestyle,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.reek,
        null_ls.builtins.diagnostics.revive,
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.ruff, -- python
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
        }),
        null_ls.builtins.diagnostics.standardrb,
        null_ls.builtins.diagnostics.staticcheck, -- golang
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.diagnostics.textlint,
        null_ls.builtins.diagnostics.tfsec,
        null_ls.builtins.diagnostics.todo_comments,
        null_ls.builtins.diagnostics.trail_space,
        null_ls.builtins.diagnostics.tsc,
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.diagnostics.xo,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.zsh,

        null_ls.builtins.formatting.stylua
    },
})
