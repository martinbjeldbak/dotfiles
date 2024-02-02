vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.o.background = "dark" -- bg=dark

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.path:append("**")
vim.opt.wildignore:append { "node_modules" }

vim.opt.swapfile = false
vim.opt.backup = false

if vim.fn.has('win32') == 1 then
    vim.opt.undodir = os.getenv("USERPROFILE") .. "/.vim/undodir"
else
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = ","

-- disable netrw as I am using nvim-tree/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- stop line breaking https://stackoverflow.com/questions/2280030/how-to-stop-line-breaking-in-vim
vim.opt.formatoptions:remove("t")

vim.g.python3_host_prog = "~/.nvimvenv/bin/python"
