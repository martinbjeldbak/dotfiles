return {
  {
    "catppuccin/nvim",
    lazy = false, -- https://github.com/folke/lazy.nvim#-colorschemes
    priority = 1000 , -- make sure to load this before all other start plugins
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
