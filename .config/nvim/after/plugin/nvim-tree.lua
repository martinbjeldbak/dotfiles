vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeFindFile)

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  respect_buf_cwd = true,
    actions = {
    open_file = {
      quit_on_open = true,
    },
    change_dir = {
      enable = true,
      global = true,
    },
  },
  view = {
      width = 40,
  },
  renderer = {
    group_empty = true,
  },
})
