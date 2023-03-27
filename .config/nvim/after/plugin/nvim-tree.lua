vim.keymap.set("n", "C-t", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeFindFile)

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
