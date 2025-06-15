return {
  { -- Autoformat
    'stevearc/conform.nvim',
    dependencies = { 'mason.nvim' },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { timeout_ms = 3000 }
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer',
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = 'fallback', -- not recommended to change
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        -- javascript = { { 'prettierd', 'prettier' } },
        -- sql = { 'sql_formatter', 'sqlfmt', 'sqlfluff', 'pg_format' },
        -- tf = { 'terraform_fmt' },
        -- ruby = { 'rubyfmt', 'rubocop', 'standardrb' },
        -- proto = { 'buf' },
        -- go = { 'gofumpt', 'goimports' },
        -- jsonnet = { 'jsonnetfmt' },
        -- json = { 'jq' },
        -- markdown = { 'markdownlint-cli2' },
        sh = { 'shellcheck', 'shfmt' },
        -- css = { 'stylelint' },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
      },
    },

    ---@param opts conform.setupOpts
    config = function(_, opts)
      require('conform').setup(opts)
    end,
  },
}
