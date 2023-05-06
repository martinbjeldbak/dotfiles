return {
  -- dashboard
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Make it rain
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = { { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Contemplate life" } },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-web-devicons",
    },
    opts = {
      theme = "catppuccin",
    },
  }
}
