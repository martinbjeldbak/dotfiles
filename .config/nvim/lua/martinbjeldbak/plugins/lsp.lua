return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
      "hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
      "hrsh7th/cmp-nvim-lsp", -- show data sent by the language server.
      "saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "b0o/schemastore.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        virtual_text = true
      }
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- mason & lspconfig setup
      require('mason').setup()

      local mlsp = require('mason-lspconfig')

      mlsp.setup({
        ensure_installed = {
          'tsserver',
          'lua_ls',
          'html',
          'bashls',
          'yamlls',
          'gopls',
        }
      })

      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lsp_attach = function(client, bufnr)
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end

      local lspconfig = require('lspconfig')
      lspconfig.jsonls.setup({
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      })

      require('cmp').setup({
        sources = {
          {name = 'path'}, -- gives completions based on the filesystem.
          {name = 'nvim_lsp'}, -- suggestions based on language server
          {name = 'buffer', keyword_length = 3}, -- provides suggestions based on the current file
          {name = 'luasnip', keyword_length = 2}, -- it shows snippets loaded by luasnip in the suggestions
        }
      })

      mlsp.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end,
      })

    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.code_actions.xo,
          null_ls.builtins.code_actions.gitsigns, -- integration with gitsigns.nvim

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
      }
    end,
  },

  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "black",
      }
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end
  }
}
