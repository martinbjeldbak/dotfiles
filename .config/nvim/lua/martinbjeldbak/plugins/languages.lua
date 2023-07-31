return {
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap", -- for debugging
      "rcarriga/nvim-dap-ui", -- dap ui
    },
    opts = {
      lsp_cfg = false, -- Use nvim-lsp: https://github.com/ray-x/go.nvim#integrate-with-mason-lspconfig
      lsp_gofumpt = true,
      fillstruct = 'gopls',
      trouble = true,
      luasnip = true,
    },
    init = function ()
      -- https://github.com/ray-x/go.nvim#run-gofmt--goimport-on-save
      -- local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*.go",
      --   callback = function()
      --     require('go.format').goimport()
      --   end,
      --   group = format_sync_grp,
      -- })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Ruby & Rails
  {
    "tpope/vim-rails",
    ft = "ruby",
  },

  -- Render markdown in browser on side
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
