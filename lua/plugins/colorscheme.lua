return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 100,
		opts = {
			style = "deep",
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 100,
		opts = {
			-- transparent = true,
			styles = {
				sidebars = "transparent",
				float = "transparent",
			},
		},
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 100,
	},
	"xiyaowong/transparent.nvim",
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
