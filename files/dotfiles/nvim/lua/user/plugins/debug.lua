return {
  -- {
  --   "erifirin/unity-dap.nvim",
  --   event = "LspAttach",
  --   opts = {
  --     -- your configuration; leave empty for default settings
  --   },
  -- },
  {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      {
        "stevearc/overseer.nvim",
        opts = {
          templates = {
            "builtin",
            "user.cpp-compile",
            "user.cpp-compile-all",
            "user.cpp-clean",
          },
        },
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = { ensure_installed = { "codelldb" } },
      },
      {
        "igorlfs/nvim-dap-view",
        enabled = true,
        opts = {},
        config = function()
          local dap, dapui = require("dap"), require("dap-view")
          dapui.setup({
            winbar = {
              -- sections = { "watches", "exceptions", "breakpoints", "threads", "repl" },
              sections = { "watches", "breakpoints", "repl" },
            },
            windows = {
              height = 8,
              terminal = { position = "right" },
            },
          })
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
        {
          name = "CODELLDB: All Files",
          type = "codelldb",
          request = "launch",
          preLaunchTask = "CompileAll",
          postDebugTask = "Clean",
          expressions = "native",
          program = "${workspaceFolder}/${fileBasenameNoExtension}",
        },
        {
          name = "CODELLDB: Select Executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp

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
