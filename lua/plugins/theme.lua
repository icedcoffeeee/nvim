return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "deep",
			transparent = true,
			highlights = {
				["@comment"] = { fg = "#aaaaaa" },
			},
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd([[colorscheme onedark]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "onedark",
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = true,
	},
}
