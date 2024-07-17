return {
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			sort_by = "case_sensitive",
			respect_buf_cwd = true,
			actions = {
				change_dir = {
					enable = true,
					global = true,
				},
			},
			view = {
				width = 40,
				side = "right",
			},
			renderer = {
				group_empty = true,
			},
			filters = { custom = { "^.git$" } },
		},
		keys = {
			{ "<C-t>", vim.cmd.NvimTreeToggle, desc = "NvimTree Toggle" },
			{ "<C-f>", vim.cmd.NvimTreeFindFile, desc = "NvimTree Find File" },
		},
	},

	-- undotree
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Undotree" },
		},
	},

	-- help align markdown tables
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.align").setup()
		end,
	},

	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", vim.cmd.Git, desc = "Git status" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
		},
		cmd = { "G", "GBrowse" },
		dependencies = {
			{ "tpope/vim-rhubarb", dependencies = { "tyru/open-browser.vim" } },
		},
	},

	-- ez file navigation
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add file to Harpoon",
			},
			{
				"<C-e>",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Toggle harpoon quick menu",
			},
			{
				"<C-1>",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Navigate to file 1",
			},
			{
				"<C-2>",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Navigate to file 2",
			},
			{
				"<C-3>",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Navigate to file 3",
			},
			{
				"<C-4>",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = "Navigate to file 4",
			},
		},
	},

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim", -- add native fzf implementation
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		keys = {
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

			-- find
			{
				"<leader>ff",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Git files",
			},
			{
				"<C-p>",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fz",
				function()
					require("telescope").extensions.live_grep_args.live_grep_args({
						vimgrep_arguments = {
							"rg",
                            "--hidden",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
						},
					})
				end,
				desc = "Live grep (root dir)",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "Searches for the string under your cursor or selection in your current working directory",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "Lists LSP references",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "Lists LSP document symbols in the current workspace",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				desc = "Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope",
			},
			{
				"<leader>fdd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers",
			},
			{
				"<leader>ft",
				function()
					require("telescope.builtin").treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
			{
				"<leader>fc",
				function()
					require("telescope.builtin").git_commits()
				end,
				desc = "Lists git commits with diff preview",
			},
			{
				"<leader>fbb",
				function()
					require("telescope.builtin").git_bcommits()
				end,
				desc = "Lists buffer's git commits with diff preview",
			},
			{
				"<leader>fB",
				function()
					require("telescope.builtin").git_branches()
				end,
				desc = "Lists all branches with log preview",
			},

			-- search
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sh", "<cmd>Telescope search_history<cr>", desc = "Search History" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git/" },
				mappings = {
					i = {
						["<C-Down>"] = function(...)
							return require("telescope.actions").cycle_history_next(...)
						end,
						["<C-Up>"] = function(...)
							return require("telescope.actions").cycle_history_prev(...)
						end,
						["<C-f>"] = function(...)
							return require("telescope.actions").preview_scrolling_down(...)
						end,
						["<C-b>"] = function(...)
							return require("telescope.actions").preview_scrolling_up(...)
						end,
						["<C-t>"] = function(...)
							require("trouble.sources.telescope").open(...)
						end,
						-- map actions.which_key to <C-h> (default: <C-/>)
						-- actions.which_key shows the mappings for your picker,
						-- e.g. git_{create, delete, ...}_branch for the git_branches picker
						["<C-h>"] = "which_key",
					},
					n = {
						["<C-t>"] = function(...)
							require("trouble.sources.telescope").open(...)
						end,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					follow = true,
				},
				-- https://github.com/nvim-telescope/telescope.nvim/issues/855#issuecomment-1032325327
				live_grep = {
					additional_args = { "--hidden" },
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
		end,
	},

	-- ultimate concentration
	{
		"folke/zen-mode.nvim",
		dependencies = {
			"folke/twilight.nvim", -- keep section in focus
		},
		opts = {
			window = {
				width = 90,
				options = {
					number = true,
					relativenumber = true,
				},
			},
			plugins = {
				tmux = { enabled = true },
			},
		},
		keys = {
			{
				"<leader>zz",
				function()
					require("zen-mode").toggle()
					vim.wo.wrap = false
				end,
				desc = "Enter zen mode",
			},
		},
	},

	-- which-key
	{
		"folke/which-key.nvim",
		opts = {
			plugins = { spelling = true },
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},

	-- show context in file
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter",
		},
	},

	-- support easy editing of surroundings
	{
		"tpope/vim-surround",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- autoclose tags
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter",
		},
	},

	-- comment stuff out
	{
		"tpope/vim-commentary",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- when using with tmux
	{
		"christoomey/vim-tmux-navigator",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- show lsp progress in bottom right
	{
		"j-hui/fidget.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			notification = {
				window = { -- setup colorscheme for catppuccin
					winblend = 0,
				},
			},
		},
	},

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},

	-- search/replace in multiple files
	{
		"nvim-pack/nvim-spectre",
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
	},

	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
		opts = {
			highlight = {
				comments_only = true,
			},
		},
	},

	-- debugging
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
		},
		keys = {
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>B",
				function()
					require("dap").set_breakpoint()
				end,
				desc = "Set breakpoint",
			},
		},
	},

	-- copilot
	{
		"github/copilot.vim",
		init = function()
			vim.g.copilot_filetypes = {
				yaml = true,
			}
		end,
	},
}
