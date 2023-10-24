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
      { "<C-y>", vim.cmd.NvimTreeToggle,   desc = "NvimTree Toggle" },
      { "<C-f>", vim.cmd.NvimTreeFindFile, desc = "NvimTree Find File" },
    },
  },

  -- Code folding
  {
    'kevinhwang91/nvim-ufo',
    event = "BufRead",
    dependencies = 'kevinhwang91/promise-async',
    init = function()
      vim.o.foldcolumn= '0'
      -- vim.o.foldcolumn = '5' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      {
        "zR",
        function()
          require('ufo').openAllFolds()
        end,
        desc = "Open all folds"
      },
      {
        "zM",
        function()
          require('ufo').closeAllFolds()
        end,
        desc = "Close all folds"
      },
    },
    -- Src: https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1514537245
    opts = {
      open_fold_hl_timeout = 400,
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
      close_fold_kinds = { "imports", "comment" },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          -- winhighlight = "Normal:Folded",
          winblend = 0,
        },
      },
    },
    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx =
        math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
        suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts["fold_virt_text_handler"] = handler
      require("ufo").setup(opts)
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          -- vim.lsp.buf.hover()
          vim.cmd [[ Lspsaga hover_doc ]]
        end
      end)
    end,
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
      { "<leader>gs", vim.cmd.Git,           desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>",   desc = "Git push" },
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
        "<C-h>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Navigate to file 1",
      },
      {
        "<C-t>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Navigate to file 2",
      },
      {
        "<C-n>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Navigate to file 3",
      },
      {
        "<C-s>",
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
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    keys = {
      { "<leader>:",  "<cmd>Telescope command_history<cr>", desc = "Command History" },

      -- find
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<C-p>",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Git files",
      },
      {
        "<leader>fz",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep (root dir)",
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
        desc = "Code references",
      },

      -- search
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",       desc = "Help Pages" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",         desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",       desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",           desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",     desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>",          desc = "Resume" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { '.git/' },
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
            ["<C-h>"] = "which_key",
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          theme = "dropdown",
        },
        -- https://github.com/nvim-telescope/telescope.nvim/issues/855#issuecomment-1032325327
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
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
    config = function()
      require("nvim-ts-autotag").setup()
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
    tag = "legacy",
    opts = {
      window = { -- setup colorscheme for catppuccin
        blend = 0,
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

  -- debugging
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      { "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
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
    event = { "BufReadPost", "BufNewFile" },
  }
}
