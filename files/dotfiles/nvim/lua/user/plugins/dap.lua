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
			dapui.setup({
				controls = { enabled = false },
				layouts = {
					{
						elements = {
							{ id = "console", size = 0.40 },
						},
						position = "bottom",
						size = 8,
					},
					{
						elements = {
							{ id = "watches", size = 0.40 },
							{ id = "scopes", size = 0.60 },
						},
						position = "top",
						size = 12,
					},
				},
			})

			local keymap = vim.keymap.set
			keymap("n", "<leader>df", dapui.float_element, { desc = "[F]loat UI element" })

			keymap("n", "<leader>dfr", function()
				dapui.float_element("repl", { position = nil })
			end, { desc = "[F]loat UI REPL" })

			dap.listeners.before.attach.dapui_config = function()
				_G.set_separators_pretty()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				_G.set_separators_pretty()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				_G.set_separators_solid()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				_G.set_separators_solid()
				dapui.close()
			end
		end,
	},

	{
		"mfussenegger/nvim-dap",
		event = "LspAttach",
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },
			{ "LiadOz/nvim-dap-repl-highlights", opts = {} },

			{
				"jay-babu/mason-nvim-dap.nvim",
				opts = {
					ensure_installed = { "cppdbg" },
				},
			},
		},

		config = function()
			local keymap = vim.keymap.set
			local dap = require "dap"

			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "OpenDebugAD7",
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
			}

			vim.fn.sign_define("DapBreakpoint", { text = "󰃤", texthl = "Error" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "󰨰", texthl = "Error" })
			vim.fn.sign_define("DapStopped", { text = "󰃤", texthl = "WarningMsg" })

			keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "[B]reakpoint" })
			keymap("n", "<leader>dc", dap.continue, { desc = "[C]ontinue" })
		end,
	},
}
