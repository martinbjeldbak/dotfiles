vim.filetype.add {
    extension = {
        tfvars = 'terraform',
    },
    filename = {
        ['Kustomization'] = "yaml",
        ['dot_zshrc.tmpl'] = "zsh"
    }
}
