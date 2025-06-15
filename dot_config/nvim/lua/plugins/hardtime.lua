return {
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      diable_mouse = false,
      disabled_keys = {
        ['<Up>'] = {},
        ['<Down>'] = {},
        ['<Left>'] = {},
        ['<Right>'] = {},
      },
      disabled_filetypes = {
        lazy = false, -- Enable Hardtime in lazy filetype
        ['dapui*'] = false, -- Enable Hardtime in filetype starting with dapui
      },
    },
  },
}
