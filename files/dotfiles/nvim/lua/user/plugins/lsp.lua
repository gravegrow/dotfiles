return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = false,
				float = { border = "single" },
				virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
			})

			vim.fn.sign_define("DiagnosticSignError", { text = "" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰰁" })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("on-lsp-keybinds", { clear = true }),
				callback = function(event)
					local keymap = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
					keymap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
					keymap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
					keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					keymap("K", vim.lsp.buf.hover, "Hover Documentation")
					keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					vim.keymap.set({ "n", "i" }, "<A-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("on-lsp-semantic", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "basedpyright" then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

			if ok then
				capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
			end

			local servers = {
				ruff_lsp = {},
				taplo = {},
				yamlls = {},
				jsonls = {},
				bashls = {},
				basedpyright = {
					settings = {
						pyright = {
							-- Using Ruff's import organizer
							disableOrganizeImports = true,
						},
						-- python = {
						-- 	analysis = {
						-- 		-- Ignore all files for analysis to exclusively use Ruff for linting
						-- 		ignore = { "*" },
						-- 	},
						-- },
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
							format = { enable = false },
						},
					},
				},
			}

			local lspconfig = require "lspconfig"
			lspconfig.gdscript.setup({ capabilities = capabilities })
			lspconfig.gdshader_lsp.setup({ capabilities = capabilities })

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"gdtoolkit",
				"shfmt",
				"prettier",
			})

			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						lspconfig[server_name].setup({
							cmd = server.cmd,
							settings = server.settings,
							filetypes = server.filetypes,
							capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
						})
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = true,
			format_after_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				markdown = { "prettier" },
				gdscript = { "gdformat" },
				sh = { "shfmt" },
				yaml = { "yamlfix" },
			},
			formatters = {
				yamlfix = {
					env = {
						YAMLFIX_SEQUENCE_STYLE = "block_style",
						YAMLFIX_WHITELINES = "1",
					},
				},
			},
		},
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			doc_lines = 0,
			handler_opts = {
				border = "single",
			},
			hint_enable = false,
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
