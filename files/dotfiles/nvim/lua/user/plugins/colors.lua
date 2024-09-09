local palette = {
	base00 = "#161617",
	base01 = "#121212",
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
	base0C = "#8EA4A2",
	base0D = "#86A1BB",
	base0E = "#C8B3CA",
	base0F = "#a3685a",
}

return {
	{
		"echasnovski/mini.base16",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd.hi 'clear'
			require("mini.base16").setup({ palette = palette })
			require("user.plugins.mini.base16").setup(palette)
			-- print(vim.inspect(require('mini.base16').mini_palette('#171717', '#9A8F8A')))
		end,
	},
}
