return {
	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "vale" }, -- "markdownlint" "vale" is very strict
				make = { "checkmake" },
				eruby = { "erb_lint" },
				ruby = { "ruby", "rubocop" },
				dockerfile = { "hadolint" },
				proto = { "buf_lint" },
				sh = { "shellcheck", "zsh" },
				lua = { "selene" },
				python = { "ruff" },
				sql = { "sqlfluff" },
				css = { "stylelint" },
				tf = { "tflint", "trivy" },
				yaml = { "yamllint" },
				go = { "revive", "golangcilint" },
				dotenv = { "dotenv_linter" },
				gitcommit = { "commitlint" },
				ghaction = { "actionlint" },
				ledger = { "hledger" },
			}

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()

					lint.try_lint("cspell") -- run on all filetypes
				end,
			})
		end,
	},
}
