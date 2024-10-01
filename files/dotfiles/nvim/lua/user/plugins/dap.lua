return {
	{
		"rcarriga/nvim-dap-ui",
		event = "LspAttach",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			local dap, dapui = require "dap", require "dapui"
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	{
		"mfussenegger/nvim-dap",
		event = "LspAttach",
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },

			{
				"jay-babu/mason-nvim-dap.nvim",
				opts = {
					handlers = {},
					ensure_installed = { "codelldb" },
				},
			},
		},

		config = function()
			local keymap = vim.keymap.set
			local dap = require "dap"

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "WarningMsg" })

			keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "[B]reakpoint" })
			keymap("n", "<leader>dc", dap.continue, { desc = "[C]ontinue" })
		end,
	},
}
