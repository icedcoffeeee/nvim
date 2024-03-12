vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		view = {
			width = 26,
		},
	},
	config = function(_, opts)
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<C-b>", api.tree.toggle, {
			desc = "nvim-tree: toggle",
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		})

		require("nvim-tree").setup(opts)
	end,
}
