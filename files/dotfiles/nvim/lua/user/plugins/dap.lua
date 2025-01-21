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

      local function open()
        vim.g.set_separators_pretty()
        dapui.open()
      end

      local function close()
        vim.g.set_separators_pretty()
        dapui.close()
      end

      dap.listeners.before.attach.dapui_config = open
      dap.listeners.before.launch.dapui_config = open
      dap.listeners.before.event_terminated.dapui_config = close
      dap.listeners.before.event_exited.dapui_config = close
    end,
  },

  {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      { "LiadOz/nvim-dap-repl-highlights", opts = {} },
      { "stevearc/overseer.nvim", opts = {} },
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          ensure_installed = { "codelldb" },
        },
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
        -- {
        -- 	name = "CODELLDB: Launch file",
        -- 	type = "codelldb",
        -- 	request = "launch",
        -- 	program = function()
        -- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        -- 	end,
        -- 	cwd = "${workspaceFolder}",
        -- 	expressions = "native",
        -- 	stopOnEntry = false,
        -- },
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
