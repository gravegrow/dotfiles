return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = false,
				virtual_text = {
					severity = { min = vim.diagnostic.severity.ERROR },
				},
			})

			vim.diagnostic.config({
				float = { border = 'single' },
			})

			vim.fn.sign_define('DiagnosticSignError', { text = '' })
			vim.fn.sign_define('DiagnosticSignWarn', { text = '' })
			vim.fn.sign_define('DiagnosticSignInfo', { text = '' })
			vim.fn.sign_define('DiagnosticSignHint', { text = '' })

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('on-lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
					map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
					map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
					map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
					map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
					map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
					map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
					map('K', vim.lsp.buf.hover, 'Hover Documentation')
					map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					vim.keymap.set({ 'n', 'i' }, '<A-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			local handlers = {
				['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
				['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
			}

			local servers = {
				ruff_lsp = {},
				pyright = {},
				taplo = {},
				yamlls = {},
				jsonls = {},
				bashls = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = 'LuaJIT' },
							workspace = {
								checkThirdParty = false,
								library = {
									'${3rd}/luv/library',
									unpack(vim.api.nvim_get_runtime_file('', true)),
								},
							},
						},
					},
				},
			}

			local lspconfig = require 'lspconfig'
			lspconfig.gdscript.setup({ capabilities = capabilities, handlers = handlers })
			lspconfig.gdshader_lsp.setup({ capabilities = capabilities, handlers = handlers })

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'stylua',
				'gdtoolkit',
				'shfmt',
			})

			require('mason').setup()
			require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
			require('mason-lspconfig').setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						lspconfig[server_name].setup({
							cmd = server.cmd,
							settings = server.settings,
							filetypes = server.filetypes,
							capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
							handlers = handlers,
						})
					end,
				},
			})
		end,
	},

	{
		'stevearc/conform.nvim',
		opts = {
			notify_on_error = true,
			format_after_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { 'stylua' },
				gdscript = { 'gdformat' },
				sh = { 'shfmt' },
			},
		},
	},
}
