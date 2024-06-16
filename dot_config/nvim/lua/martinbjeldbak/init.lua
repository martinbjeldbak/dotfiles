require("martinbjeldbak.remap")
require("martinbjeldbak.set")

require("lazy").setup("martinbjeldbak.plugins", {
  change_detection = {
    notify = false,
  }
})

vim.filetype.add {
    extension = {
        tfvars = 'terraform',
    },
    pattern = {
        ['Kustomization'] = "yaml",
        ['dot_zshrc.tmpl'] = "zsh",
        ['.*%.toml%.tmpl'] = "toml",
        [".*/hypr/.*%.conf"] = "hyprlang"
    },
}
