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
      },
      renderer = {
        group_empty = true,
      },
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

  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Git" }
    },
  },
  {
    "tpope/vim-rhubarb",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "tyru/open-browser.vim", -- support :GBrowse, see https://github.com/tpope/vim-rhubarb/issues/62
    },
    cmd = "GBrowse",
  },

  -- ez file navigation
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to Harpoon" },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle harpoon quick menu" },
      { "<C-1>", function() require("harpoon.ui").nav_file(1) end, desc = "Navigate to file 1" },
      { "<C-2>", function() require("harpoon.ui").nav_file(2) end, desc = "Navigate to file 2" },
      { "<C-3>", function() require("harpoon.ui").nav_file(3) end, desc = "Navigate to file 3" },
      { "<C-4>", function() require("harpoon.ui").nav_file(4) end, desc = "Navigate to file 4" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim", -- add native fzf implementation
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Find files" },
      { "<C-p>", function() require('telescope.builtin').git_files() end, desc = "Git files" },
      { '<leader>fz', function() require('telescope.builtin').live_grep() end, desc = "Live grep" },
      { '<leader>fg', function() require('telescope.builtin').grep_string() end, desc = "Grep for string" },
      { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = "Buffers" },
    },
    opts = {
      defaults = {
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
          },
        },
        pickers = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end
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
        }
      },
    },
    keys = {
      { "<leader>zz", function()
        require("zen-mode").toggle()
        vim.wo.wrap = false
      end, desc = "Enter zen mode" },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
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
      window = { -- setup colorscheme for catppuccin
        blend = 0
      },
    },
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
  }
}
