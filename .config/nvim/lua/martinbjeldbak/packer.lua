-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    use('nvim-telescope/telescope-fzf-native.nvim', { run = 'make' })
	use({
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	})


	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			require("rose-pine").setup()
			vim.cmd('colorscheme rose-pine')
		end
	})

    use({
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    })

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
	use('tpope/vim-rhubarb')
	use('tyru/open-browser.vim') -- support :GBrowse, see https://github.com/tpope/vim-rhubarb/issues/62
	use('tpope/vim-surround')
	use('tpope/vim-commentary')
    use('iamcco/markdown-preview.nvim', { run = 'cd app && yarn install', cmd = 'MarkdownPreview'})
    use("b0o/schemastore.nvim")
    use("christoomey/vim-tmux-navigator")

    use("f-person/auto-dark-mode.nvim")

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			{'saadparwaiz1/cmp_luasnip'}, -- Optional
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		}
	}

    use('folke/zen-mode.nvim')
    use('eandrju/cellular-automaton.nvim')

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })
    use('fatih/vim-go', { run = ':GoUpdateBinaries' })
    use('buoto/gotests-vim')
end)

