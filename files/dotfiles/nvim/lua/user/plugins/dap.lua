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
					-- {
					-- 	elements = { { id = "stacks", size = 1 } },
					-- 	position = "bottom",
					-- 	size = 3,
					-- },
					{
						elements = {
							{ id = "repl", size = 0.60 },
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
						size = 8,
					},
				},
			})

			vim.api.nvim_create_autocmd({ "FileType", "BufReadPost" }, {
				pattern = { "dapui*" },
				group = vim.api.nvim_create_augroup("dapui-opts", { clear = true }),
				callback = function()
					vim.opt.colorcolumn = { 0 }
				end,
			})

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
					handlers = {},
					ensure_installed = { "cppdbg" },
				},
			},
		},

		config = function()
			local keymap = vim.keymap.set
			local dap = require "dap"

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "Warn" })

			keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "[B]reakpoint" })
			keymap("n", "<leader>dc", dap.continue, { desc = "[C]ontinue" })
		end,
	},
}
