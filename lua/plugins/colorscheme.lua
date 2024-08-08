return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				float = "transparent",
			},
		},
		init = function()
			vim.cmd([[colorscheme tokyonight-storm]])
			vim.api.nvim_create_user_command("ToggleTrans", function()
				vim.g.transparent = not vim.g.transparent
				local bg_dark = vim.g.transparent and require("tokyonight.colors").setup().bg_dark or 'none'
				vim.cmd("hi Normal guibg=" .. bg_dark)
			end, {
				desc = "Toggle transparency",
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				indicator = { style = "underline" },
				diagnostics = "nvim_lsp",
				sort_by = "insert_after_current",
			},
		},
	},
}
