return {
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lsp_cfg = false, -- Use nvim-lsp: https://github.com/ray-x/go.nvim#integrate-with-mason-lspconfig
      lsp_gofumpt = true,
      fillstruct = 'gopls',
      -- trouble = true,
      luasnip = true,
    },
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Ruby & Rails
  {
    "tpope/vim-rails",
    ft = "ruby",
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
