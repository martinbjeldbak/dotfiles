local sql_ft = { 'sql', 'mysql', 'plsql' }

return {
  {
    'tpope/vim-dadbod',
    cmd = 'DB',
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = 'vim-dadbod',
    ft = sql_ft,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    dependencies = 'vim-dadbod',
    keys = {
      { '<leader>D', '<cmd>DBUIToggle<CR>', desc = 'Toggle DBUI' },
    },
    init = function()
      local data_path = vim.fn.stdpath 'data'

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false

      vim.g.db_adapter_bigquery_region = 'region-australia-southeast1'
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'sql' } },
  },

  -- Edgy integration
  {
    'folke/edgy.nvim',
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = 'Database',
        ft = 'dbui',
        pinned = true,
        width = 0.3,
        open = function()
          vim.cmd 'DBUI'
        end,
      })

      opts.bottom = opts.bottom or {}
      table.insert(opts.bottom, {
        title = 'DB Query Result',
        ft = 'dbout',
      })
    end,
  },

  -- blink.cmp integration
  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        default = { 'dadbod' },
        providers = {
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        },
      },
    },
    dependencies = {
      'kristijanhusak/vim-dadbod-completion',
    },
  },

  -- Linters & formatters
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'sqlfluff' } },
  },
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      for _, ft in ipairs(sql_ft) do
        opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
        table.insert(opts.linters_by_ft[ft], 'sqlfluff')
      end
    end,
          },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters.sqlfluff = {
        args = { 'format', '--dialect=ansi', '-' },
      }
      for _, ft in ipairs(sql_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], 'sqlfluff')
      end
    end,
  },
}
