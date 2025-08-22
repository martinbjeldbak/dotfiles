return {
  {
    'nvim-treesitter/nvim-treesitter',
              opts = { ensure_installed = { 'ninja', 'rst' } },
                  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local servers = { 'ty', 'ruff' }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].enabled = true
      end
    end,
  },
  {
    'nvim-neotest/neotest',
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
    dependencies = {
      'mfussenegger/nvim-dap-python',
			-- stylua: ignore
      			keys = {
      			  { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      			  { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
			},
    },
  },

  -- Don't mess up DAP adapters provided by nvim-dap-python
  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      handlers = {
        python = function() end,
      },
    },
  },
}
