return -- search/replace in multiple files
{
  'nvim-pack/nvim-spectre',
  opts = {
    replace_engine = { -- https://github.com/nvim-pack/nvim-spectre/issues/118#issuecomment-1531683211
      ['sed'] = {
        cmd = 'sed',
        args = {
          '-i',
          '',
          '-E',
        },
      },
    },
  },
  keys = {
    {
      '<leader>sR',
      function()
        require('spectre').open()
      end,
      desc = 'Replace in files (Spectre)',
    },
  },
}
