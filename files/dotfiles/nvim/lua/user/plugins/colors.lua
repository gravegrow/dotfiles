local palette = {
	base00 = "#161617",
	base01 = "#0d0d0d",
	base02 = "#212121",
	base03 = "#2b2b2b",
	base04 = "#544c45",
	base05 = "#9e9794",
	base06 = "#464646",
	base07 = "#807E96",
	base08 = "#945B5B",
	base09 = "#B7927B",
	base0A = "#C4B28A",
	base0B = "#8A9A7B",
	base0C = "#97B7B3",
	base0D = "#86A1BB",
	base0E = "#977B9F",
	base0F = "#a3685a",
}

return {
	-- {
	-- 	"echasnovski/mini.base16",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- vim.cmd.hi 'clear'
	-- 		require("mini.base16").setup({ palette = palette })
	-- 		require("user.plugins.mini.base16").setup(palette)
	-- 		-- print(vim.inspect(require('mini.base16').mini_palette('#171717', '#9A8F8A')))
	-- 	end,
	-- },

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,

		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					comments = { italic = true },
					keywords = { bold = true, italic = false },
					functions = {},
					variables = {},
				},
				style = "night",
				dim_inactive = false,
				on_highlights = function(hl, colors)
					hl.MacroRecording = { fg = colors.error, bold = true }
					hl.FzfLuaNormal = { link = "Normal" }
					hl.FzfLuaBorder = { fg = colors.blue, bg = colors.bg }
					hl.FzfLuaPreviewNormal = { bg = colors.bg_dark }
					hl.FzfLuaPreviewBorder = { fg = colors.bg_dark, bg = colors.bg_dark }
					hl.FzfLuaDirPart = { fg = colors.comment }
					hl.StatusLine = { fg = colors.fg, bg = colors.black, bold = true }
					hl.StatusLineFill = { fg = colors.comment, bg = colors.bg_dark }
					hl.StatusLineModified = { fg = colors.warning, bg = colors.bg_dark }
					hl.StatusError = { bg = colors.error, fg = colors.bg, bold = true }
					hl.StatusWarn = { bg = colors.warning, fg = colors.bg, bold = true }
					hl.StatusInfo = { bg = colors.info, fg = colors.bg, bold = true }
					hl.StatusHint = { bg = colors.hint, fg = colors.bg, bold = true }
					hl.YankHighlight = { fg = palette.base0F, bold = true }
					hl.TreesitterContext = { bg = colors.bg_dark }
				end,
				on_colors = function(colors)
					colors.bg = palette.base00
					colors.bg_dark = palette.base01
					colors.bg_float = colors.bg_dark
					colors.bg_highlight = palette.base03
					colors.bg_popup = colors.bg_dark
					colors.bg_search = "#3d59a1"
					colors.bg_sidebar = colors.bg_dark
					colors.bg_statusline = palette.base03
					colors.bg_visual = palette.base03
					colors.black = colors.bg_highlight
					colors.blue = palette.base0D
					colors.blue0 = "#3d59a1"
					colors.blue1 = palette.base09
					colors.blue2 = colors.blue
					colors.blue5 = palette.base09
					colors.blue6 = palette.base0C
					colors.blue7 = "#394b70"
					colors.border = colors.bg_dark
					colors.border_highlight = palette.base07
					colors.comment = palette.base06
					colors.cyan = palette.base0C
					colors.dark3 = "#545c7e"
					colors.dark5 = "#737aa2"
					colors.diff = {
						add = "#20303b",
						change = "#1f2231",
						delete = "#37222c",
						text = "#394b70",
					}
					colors.error = "#db4b4b"
					colors.fg = palette.base05
					colors.fg_dark = "#a9b1d6"
					colors.fg_float = colors.fg
					colors.fg_gutter = palette.base06
					colors.fg_sidebar = "#a9b1d6"
					colors.git = {
						add = "#449dab",
						change = "#6183bb",
						delete = "#914c54",
						ignore = "#545c7e",
					}
					colors.green = palette.base0B
					colors.green1 = palette.base07
					colors.green2 = "#41a6b5"
					colors.hint = "#1abc9c"
					colors.info = "#0db9d7"
					colors.magenta = palette.base08
					colors.magenta2 = "#ff007c"
					colors.none = "NONE"
					colors.orange = palette.base09
					colors.purple = palette.base07
					colors.rainbow = {
						"#7aa2f7",
						"#e0af68",
						"#9ece6a",
						"#1abc9c",
						"#bb9af7",
						"#9d7cd8",
					}
					colors.red = palette.base08
					colors.red1 = "#db4b4b"
					colors.teal = palette.base0C
					colors.terminal_black = colors.comment
					colors.todo = "#7aa2f7"
					colors.warning = "#e0af68"
					colors.yellow = palette.base0A
				end,
			})

			vim.cmd.colorscheme "tokyonight"
		end,
	},

	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nordic").load()
	-- 	end,
	-- },
}
