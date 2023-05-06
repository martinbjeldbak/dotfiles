return {
  -- Golang
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoUpdateBinaries",
    config = function()
      vim.g.go_decls_mode = "fzf"
      vim.g.go_fmt_command = "goimports"
    end
  },
  {
    "buoto/gotests-vim",
    ft = "go",
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
