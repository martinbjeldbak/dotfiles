return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ninja', 'rst' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local servers = { 'basedpyright', 'ruff' }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].enabled = true
      end
    end,
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'nvim-neotest/neotest-python',
    },
    opts = {
      adapters = {
        ['neotest-python'] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      'mfussenegger/nvim-dap-python',
			-- stylua: ignore
      			keys = {
      			  { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      			  { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
			},
    },
  },

  {
    'hrsh7th/nvim-cmp',
    optional = true,
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, 'python')
    end,
  },

  -- Don't mess up DAP adapters provided by nvim-dap-python
  {
    'jay-babu/mason-nvim-dap.nvim',
    optional = true,
    opts = {
      handlers = {
        python = function() end,
      },
    },
  },
}
