return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.adapters.godot = {
      type = 'server',
      host = '127.0.0.1',
      port = 6006,
    }

    dap.configurations.gdscript = {
      {
        type = 'godot',
        request = 'launch',
        name = 'Launch scene',
        project = '${workspaceFolder}',
        launch_scene = false,
      },
    }

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          position = 'bottom',
          size = 10,
        },
      },
    })
    require('nvim-dap-virtual-text').setup()

    local namespace = vim.api.nvim_create_namespace 'dap-hlng'
    vim.api.nvim_set_hl(namespace, 'DapBreakpoint', { fg = '#F38BA8' })
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ap Toglle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ap [C]ontinue' })

    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  end,
}
