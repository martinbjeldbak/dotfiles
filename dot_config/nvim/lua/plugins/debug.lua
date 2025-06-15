return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps
      -- { "<F5>", dap.continue, desc = "Debug: Start/Continue" },
      -- { "<F1>", dap.step_into, desc = "Debug: Step Into" },
      -- { "<F2>", dap.step_over, desc = "Debug: Step Over" },
      -- { "<F3>", dap.step_out, desc = "Debug: Step Out" },
      { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      -- { "<F7>", dapui.toggle, desc = "Debug: See last session result." },
      -- unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Conditionally set keybinds
    -- See https://github.com/rcarriga/nvim-dap-ui/issues/134#issuecomment-2656882128
    dap.listeners.after.event_initialized['me.dap.keys'] = function()
      vim.keymap.set('n', 'c', dap.continue, { desc = 'Debug: Continue' })
      vim.keymap.set('n', '<right>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<up>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<down>', dap.step_into, { desc = 'Debug: Step Into' })
    end
    local reset_keys = function()
      pcall(vim.keymap.del, 'n', 'c')
      pcall(vim.keymap.del, 'n', '<down>')
      pcall(vim.keymap.del, 'n', '<up>')
      pcall(vim.keymap.del, 'n', '<right>')
    end
    dap.listeners.after.event_terminated['me.dap.keys'] = reset_keys
    dap.listeners.after.disconnected['me.dap.keys'] = reset_keys

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
