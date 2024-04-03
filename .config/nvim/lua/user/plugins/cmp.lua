return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			build = (function()
				return 'make install_jsregexp'
			end)(),
		},
		'lukas-reineke/cmp-under-comparator',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'onsails/lspkind.nvim',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
		local lspkind = require 'lspkind'
		local defaults = require 'cmp.config.default'()

		luasnip.config.setup({})

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-y>'] = cmp.mapping(
					cmp.mapping.confirm({
						select = true,
					}),
					{ 'i', 'c' }
				),
				['<C-l>'] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { 'i', 's' }),
				['<C-h>'] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { 'i', 's' }),
			}),
			-- completion = { completeopt = 'menu,menuone,noinsert,noselect' },
			preselect = cmp.PreselectMode.None,
			window = {
				documentation = { winhighlight = 'Normal:CmpDoc,FloatBorder:CmpDocBorder' },
				completion = cmp.config.window.bordered({
					winhighlight = 'FloatBorder:CmpBorder,Normal:Normal',
				}),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = 'text_symbol',
					-- menu = {
					-- 	-- stylua: ignore start
					-- nvim_lsp = '[LSP]',
					-- 	path     = '[PTH]',
					-- 	neorg    = '[NRG]',
					-- 	buffer   = '[BUF]',
					-- 	luasnip  = '[SNP]',
					-- 	-- stylua: ignore end
					-- },
					maxwidth = 25,
					ellipsis_char = '...',
					show_labelDetails = true,
					before = function(entry, vim_item)
						local label = vim_item.abbr
						local minwidth = 25
						if string.len(label) < minwidth then
							local padding = string.rep(' ', minwidth - string.len(label))
							vim_item.abbr = label .. padding
						end
						if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= '' then
							vim_item.menu = entry.completion_item.detail
						end
						vim_item.dup = { buffer = 1, path = 1, nvim_lsp = 0 }
						return vim_item
					end,
				}),
			},
			sources = cmp.config.sources({
				{
					name = 'nvim_lsp',
					entry_filter = function(entry, ctx)
						return require('cmp').lsp.CompletionItemKind.Text ~= entry:get_kind()
					end,
				},
				{ name = 'path' },
				{ name = 'neorg' },
				{ name = 'luasnip' },
			}, {
				{ name = 'buffer', keyword_length = 3 },
			}),
			-- sorting = defaults.sorting,
			sorting = {
				comparators = {
					cmp.config.compare.score,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					require('cmp-under-comparator').under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		})

		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' },
			},
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline({
				['<C-y>'] = {
					c = cmp.mapping.confirm({ select = true }),
				},
			}),
			sources = cmp.config.sources({
				{ name = 'path' },
			}, {
				{ name = 'cmdline' },
			}),
		})

		require('luasnip.loaders.from_vscode').lazy_load()
	end,
}
