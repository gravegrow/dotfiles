return {
  {
    "rcarriga/nvim-dap-ui",
    event = "LspAttach",
    enabled = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },

    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup({
        controls = { enabled = false },
        layouts = {
          {
            elements = {
              { id = "console", size = 0.60 },
            },
            position = "bottom",
            size = 0.25,
          },
          {
            elements = {
              { id = "watches", size = 0.50 },
              { id = "breakpoints", size = 0.50 },
            },
            position = "top",
            size = 0.25,
          },
        },
      })

      local keymap = vim.keymap.set
      keymap("n", "<leader>df", dapui.float_element, { desc = "[F]loat UI element" })

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close
    end,
  },

  {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      {
        "stevearc/overseer.nvim",
        opts = { templates = { "builtin", "user.cpp.compile", "user.cpp.clean" } },
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = { ensure_installed = { "codelldb" } },
      },
      {
        "igorlfs/nvim-dap-view",
        enabled = false,
        opts = {},
        config = function()
          local dap, dapui = require("dap"), require("dap-view")
          dap.listeners.before.attach.dapui_config = dapui.open
          dap.listeners.before.launch.dapui_config = dapui.open
          dap.listeners.before.event_terminated.dapui_config = dapui.close
          dap.listeners.before.event_exited.dapui_config = dapui.close
        end,
      },
    },

    config = function()
      local keymap = vim.keymap.set
      local dap = require("dap")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "CODELLDB: Current File",
          type = "codelldb",
          request = "launch",
          preLaunchTask = "Compile",
          postDebugTask = "Clean",
          expressions = "native",
          program = "${workspaceFolder}/${fileBasenameNoExtension}",
        },
      }

      vim.fn.sign_define("DapBreakpoint", { text = "󰃤", texthl = "Error" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "󰨰", texthl = "Error" })
      vim.fn.sign_define("DapStopped", { text = "󰜴", texthl = "Added" })

      keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "[B]reakpoint" })
      keymap("n", "<leader>dc", dap.continue, { desc = "[C]ontinue" })
      keymap("n", "<leader>dr", dap.repl.toggle, { desc = "[R]EPL" })
      keymap("n", "<leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes, { border = "single" })
      end, { desc = "[S]copes" })

      keymap("n", "<M-j>", dap.step_over, { desc = "Dap Step Over" })
      keymap("n", "<M-k>", dap.step_back, { desc = "Dap Step Back" })
      keymap("n", "<M-l>", dap.step_into, { desc = "Dap Step In" })
      keymap("n", "<M-h>", dap.step_out, { desc = "Dap Step Out" })
    end,
  },
}
