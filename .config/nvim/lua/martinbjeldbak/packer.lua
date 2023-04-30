-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    use({'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })

	use({
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	})


    -- theming
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function ()
            vim.cmd.colorscheme "catppuccin"
        end
    })

    use({
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    })

    use({
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end
    })

    use({
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    })

    use('tpope/vim-rails')

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use('nvim-treesitter/nvim-treesitter-context')
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
	use('tpope/vim-rhubarb')
	use('tyru/open-browser.vim') -- support :GBrowse, see https://github.com/tpope/vim-rhubarb/issues/62
	use('tpope/vim-surround')
	use('tpope/vim-commentary')
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use("b0o/schemastore.nvim")
    use("christoomey/vim-tmux-navigator")

    use("f-person/auto-dark-mode.nvim")

    use({
        'j-hui/fidget.nvim',
        config = function()
            require("fidget").setup({
                -- setup colorscheme for catppuccin
                window = {
                    blend = 0,
                }
            })
        end
    })

    use({
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    })

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
            {                                      -- Optional
              'williamboman/mason.nvim',
               run = function()
                 pcall(vim.cmd, 'MasonUpdate')
               end,
            },
			{'williamboman/mason-lspconfig.nvim'},
			-- LSP Support
			{'neovim/nvim-lspconfig'},

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

    use('folke/twilight.nvim')
    use('folke/zen-mode.nvim')
    use('eandrju/cellular-automaton.nvim')

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                options = {
                    theme = "catppuccin"
                }
            }
        end
    })
    use('fatih/vim-go', { run = ':GoUpdateBinaries' })
    use('buoto/gotests-vim')
end)

