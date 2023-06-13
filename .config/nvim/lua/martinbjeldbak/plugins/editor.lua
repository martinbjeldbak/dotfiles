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
      { "<C-t>", vim.cmd.NvimTreeToggle,   desc = "NvimTree Toggle" },
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
      { "<leader>gs", vim.cmd.Git,           desc = "Git status" },
      { "<leader>gc", '<cmd>Git commit<cr>', desc = "Git commit" },
      { "<leader>gp", '<cmd>Git push<cr>',   desc = "Git push" },
    },
    cmd = "G",
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
      { "<leader>a", function() require("harpoon.mark").add_file() end,        desc = "Add file to Harpoon" },
      { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle harpoon quick menu" },
      { "<C-1>",     function() require("harpoon.ui").nav_file(1) end,         desc = "Navigate to file 1" },
      { "<C-2>",     function() require("harpoon.ui").nav_file(2) end,         desc = "Navigate to file 2" },
      { "<C-3>",     function() require("harpoon.ui").nav_file(3) end,         desc = "Navigate to file 3" },
      { "<C-4>",     function() require("harpoon.ui").nav_file(4) end,         desc = "Navigate to file 4" },
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
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    keys = {
      { "<leader>:",  "<cmd>Telescope command_history<cr>",                      desc = "Command History" },

      -- find
      { "<leader>ff", function() require('telescope.builtin').find_files() end,  desc = "Find files" },
      { "<C-p>",      function() require('telescope.builtin').git_files() end,   desc = "Git files" },
      { '<leader>fz', function() require('telescope.builtin').live_grep() end,   desc = "Live grep (root dir)" },
      { '<leader>fg', function() require('telescope.builtin').grep_string() end, desc = "Grep for string under cursor" },
      { '<leader>fb', function() require('telescope.builtin').buffers() end,     desc = "Buffers" },

      -- search
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                            desc = "Help Pages" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                              desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                            desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                                desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",                          desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>",                               desc = "Resume" },
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
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        -- https://github.com/nvim-telescope/telescope.nvim/issues/855#issuecomment-1032325327
        live_grep = {
          additional_args = function ()
            return {"--hidden"}
          end
        }
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
      {
        "<leader>zz",
        function()
          require("zen-mode").toggle()
          vim.wo.wrap = false
        end,
        desc = "Enter zen mode"
      },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 300

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

  -- autoclose tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter",
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
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
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
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
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
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
  },
}
