return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "html", "css", "typescript", "tsx", "json", "svelte", "python", "rust" },
			sync_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
		vim.cmd([[TSEnable highlight]])
		vim.cmd([[TSEnable indent]])
	end,
}
