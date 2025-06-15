return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      'BufReadPre ' .. vim.fn.expand '~' .. '/Documents/main/*.md',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      ui = { enable = false },

      daily_notes = {
        -- Optional, default tags to add to each new daily note created.
        default_tags = { 'daily-notes' },
        template = 'daily-notes.md',
      },
      workspaces = {
        {
          name = 'personal',
          path = '~/Documents/main',
        },
      },
    },
  },
}
