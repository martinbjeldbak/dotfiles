return {
  {
    "catppuccin/nvim",
    lazy = false, -- https://github.com/folke/lazy.nvim#-colorschemes
    priority = 1000 , -- make sure to load this before all other start plugins
    config = function()
      require('catppuccin').setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
        integrations = {
          which_key = true,
          lsp_trouble = true,
          harpoon = true,
        },
      })

      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
