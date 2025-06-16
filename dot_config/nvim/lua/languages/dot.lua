return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'shellcheck' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local function add(lang)
        if type(opts.ensure_installed) == 'table' then
          table.insert(opts.ensure_installed, lang)
        end
      end

      vim.filetype.add {
        extension = { rasi = 'rasi', rofi = 'rasi', wofi = 'rasi' },
        filename = {
          ['vifmrc'] = 'vim',
        },
        pattern = {
          ['.*/waybar/config'] = 'jsonc',
          ['.*/hypr/.+%.conf'] = 'hyprlang',
          ['%.env%.[%w_.-]+'] = 'sh',
          ['.env'] = 'dotenv',
        },
      }

      add 'git_config'
      add 'hyprlang'
      add 'rasi'
    end,
  },
}
