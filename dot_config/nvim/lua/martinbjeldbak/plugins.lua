return {
  {
    "catppuccin/nvim",
    lazy = false, -- https://github.com/folke/lazy.nvim#-colorschemes
    priority = 1000 , -- make sure to load this before all other start plugins
    config = function()
      require('catppuccin').setup({
        background = {
          light = "latte",
          dark = "frappe",
        },
        integrations = {
          harpoon = true,
          leap = true,
          lsp_trouble = true,
          markdown = true,
          mason = true,
          mini = true,
          treesitter_context = true,
          which_key = true,
        },
      })

      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
