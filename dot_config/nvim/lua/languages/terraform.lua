return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'terraform', 'hcl' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        terraformls = {},
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'tflint' } },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        terraform = { 'terraform_validate, tflint' },
        tf = { 'terraform_validate, tflint' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        hcl = { 'packer_fmt' },
        terraform = { 'terraform_fmt' },
        tf = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
      },
    },
  },
}
