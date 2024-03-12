return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = { "lua", "html", "css", "typescript", "tsx", "json", "svelte", "python", "rust" },
		sync_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)
		vim.cmd([[TSEnable highlight]])
		vim.cmd([[TSEnable indent]])
	end,
}
